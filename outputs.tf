output "publicip" {
  value = "${aws_instance.exam.public_ip}"
}
output "all" {
  value = "${aws_instance.exam}"
}
