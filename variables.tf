variable "name" {
  default     = "openvpn"
  description = "OpenVPN instance name"
}

variable "vpc_id" {
  description = "ID of the VPC to use"
}

variable "vpc_cidr" {
  description = "VPC CIDRs to use"
}

variable "public_subnet_ids" {
  description = "Public Subnet IDs"
}

variable "instance_type" {
  description = "OPenVPN EC2 instance type"
}

variable "key_name" {
  description = "Key Pair name"
}

variable "ebs_region" {
  description = "Region for the EBS volume where we'll store credentials and certificates"
}

variable "ebs_size" {
  description = "EBS volume size. 1GB should be fine in most cases"
}

variable "ami" {
  description = "AMI ID to use for the EC2 instance"
}

variable "ssh_key_file" {
  description = "SSH key"
}

variable "openvpn_clients_file" {
  description = "File containing openvpn users"
}

variable "ec2_user" {
  description = "AMI ID to use for the EC2 instance"
}