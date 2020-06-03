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
