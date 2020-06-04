variable "region" {
  default     = "us-east-1"
  description = "region"
}
variable "ami_id" {
  description = "ami image id"
  default     = "ami-01b670d1a5b2c1da7"
}

variable "inst_type" {
  description = "instance type"
  default     = "t2.small"
}

variable "key_pair" {
  description = "key pair name"
}

variable "INSTANCE_USERNAME" {
  description = "windows user"
  }

variable "INSTANCE_PASSWORD" {
  description = "windows user password"
  }

variable "vpc_id" {
  default = "vpc-bc944bc7"
  }
