terraform {
  backend "s3" {}
}

provider "aws" {
  region  = var.region
  version = "~> 2.54.0"
}

data “aws_ami” “Windows_2016” {
 filter {
 name = “is-public”
 values = [“false”]
 }
  
filter {
 name = “name”
 values = [“windows2016Server*”]
 }
most_recent = true
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

resource "aws_instance" "exam" {
  ami           = “${data.aws_ami.Windows_2016.image_id}”
  instance_type = var.inst_type
  key_name      = var.key_pair
  user_data = data.template_file.userdata_win.rendered

  root_block_device {
    volume_type = “ebs”
    volume_size = 50
    delete_on_termination = “true”
 }

  tags = {
    Name = "TFCloud-VM"
  }
}
