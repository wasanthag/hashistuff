output "publicip" {
  value = "${aws_instance.tfec2.public_ip}"
}
output "all" {
  value = "${aws_instance.tfec2}"
}
