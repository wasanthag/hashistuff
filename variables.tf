variable "region" {
  default     = "us-east-1"
  description = "region"
}
variable "ami_id" {
  description = "ami image id"
  default     = "ami-0fc916cb89db443ce"
}

variable "inst_type" {
  description = "instance type"
  default     = "t2.small"
}

variable "key_pair" {
  description = "key pair name"
}
