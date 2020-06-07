resource "aws_security_group" "openvpn" {
  name        = var.name
  vpc_id      = var.vpc_id
  description = "OpenVPN security group"

  tags = {
    Name = var.name
  }

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.vpc_cidr]
  }

  # For OpenVPN Client Web Server & Admin Web UI
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "udp"
    from_port   = 1194
    to_port     = 1194
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ebs_volume" "openvpn_data" {
  availability_zone = var.ebs_region
  size              = var.ebs_size
  encrypted         = true

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_instance" "openvpn" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.public_subnet_ids

  vpc_security_group_ids = [aws_security_group.openvpn.id]

  tags = {
    Name = var.name
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  instance_id = aws_instance.openvpn.id
  volume_id   = aws_ebs_volume.openvpn_data.id

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ${var.ec2_user} --extra-vars @${var.openvpn_clients_file} --private-key ${var.ssh_key_file} -i '${aws_instance.openvpn.public_ip},' ${path.module}/config/ansible/openvpn.yml"
  }
}

