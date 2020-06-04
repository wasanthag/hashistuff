terraform {
  backend "s3" {}
}

provider "aws" {
  region  = var.region
  version = "~> 2.54.0"
}

data "aws_vpc" "default" {
  id = "${var.vpc_id}"
}

data "template_file" "userdata_win" {
  template = <<EOF
<script>
echo "" > _INIT_STARTED_
net user ${var.INSTANCE_USERNAME} /add /y
net user ${var.INSTANCE_USERNAME} ${var.INSTANCE_PASSWORD}
net localgroup administrators ${var.INSTANCE_USERNAME} /add
echo "" > _INIT_COMPLETE_
</script>
<persist>false</persist>
EOF
}

data "aws_ami" "windows_2016" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["Windows_Server-2016-English-Core-Base-*"]
    }
  filter {
    name = "is-public"
    values = ["true"]
  }
  }

resource "aws_security_group" "allow_rdp" {
  name        = "allow_rdp"
  description = "Allow RDP inbound traffic"
  vpc_id      = "vpc-bc944bc7"

  ingress {
    description = "Open RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = aws_vpc.default.cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_rdp"
  }
}

resource "aws_instance" "tfec2" {
  ami = data.aws_ami.windows_2016.image_id
  instance_type = var.inst_type
  key_name      = var.key_pair
  user_data = data.template_file.userdata_win.rendered
  
  tags = {
    Name = "TFCloud-VM"
  }
}
