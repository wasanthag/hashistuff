output "publicip" {
  value = "${aws_instance.exam.public_ip}"
}
output "Administrator_Password" {
 value = "${rsadecrypt(aws_instance.tfec2.password_data, file("${module.ssh_key_pair.private_key_filename}"))}"
}
output "all" {
  value = "${aws_instance.exam}"
}
