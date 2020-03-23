output "publicip" {
  value = "${aws_instance.exam.public_ip}"
}
