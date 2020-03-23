variable "region" {
  default     = "us-east-1"
  description = "region"
}
variable "ami_id" {
  description = "ami image id"
  default     = "ami-03bac73ab0003d2ea"

}

variable "inst_type" {
  description = "instance type"
  default     = "t2.small"
}

variable "key_pair" {
  description = "key pair name"
}
