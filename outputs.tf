output "private_ip" {
  value = "${aws_instance.openvpn.private_ip}"
}

output "public_ip" {
  value = "${aws_instance.openvpn.public_ip}"
}

output "security_group_id" {
  value = "${aws_security_group.openvpn.id}"
}