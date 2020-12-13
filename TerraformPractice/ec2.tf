resource "aws_instance" "bmo-ec2-instance" {
  ami           = var.aws_ec2_ami
  instance_type = var.aws_ec2_instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id] 
  subnet_id = aws_subnet.bmo_public_subnet.id
  iam_instance_profile = aws_iam_instance_profile.delegate_admin_ec2_profile.name
  key_name = "bmo-private-instance"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    encrypted = true
    kms_key_id = aws_kms_key.delegate_admin_kms_key.arn
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = 20
    encrypted = true
    kms_key_id = aws_kms_key.delegate_admin_kms_key.arn
    delete_on_termination = false
  }



  tags = merge(
    local.labels,
    map("Name", local.ec2_instance_name)
  )
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.bmo_custom_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = var.tcp_protocol
    cidr_blocks = [aws_vpc.bmo_custom_vpc.cidr_block]
  }

  ingress {
    description = "TCP for SSH"
    from_port   = var.tcp_port
    to_port     = var.tcp_port
    protocol    = var.tcp_protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr_block
  }

  tags = {
    Name = "allow_tls"
  }
}