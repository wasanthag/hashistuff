terraform {
  backend "s3" {}
}

provider "aws" {
  region  = var.region
  version = "~> 2.54.0"
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
  ami           = var.ami_id
  instance_type = var.inst_type
  key_name      = var.key_pair
  user_data = data.template_file.userdata_win.rendered

  tags = {
    Name = "exam"
  }
}
