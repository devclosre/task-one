### Using Template file
data "template_file" "ansible_userdata" {
  template = file("ansible_install.sh")
}

### Install Ansible Server
resource "aws_instance" "ansible_master" {
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = var.instance_keypair
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnets[0].id
  vpc_security_group_ids      = [aws_security_group.web-sg.id]
  user_data                   = data.template_file.ansible_userdata.rendered

  tags = {
    Name = "ansible_master"
  }
}






