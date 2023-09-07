### Using Template file
data "template_file" "nginx_userdata" {
  template = file("./nginx_install.sh")
}

### Launch Configuration for ASG
resource "aws_launch_configuration" "web-instance-lc" {
  name_prefix     = "web-instance-lc"
  image_id        = data.aws_ami.ubuntu.id # Ubuntu AMI from ap-southeast-4
  instance_type   = "t3.micro"
  key_name        = var.instance_keypair
  security_groups = [aws_security_group.web-sg.id]
  user_data       = data.template_file.nginx_userdata.rendered

}

### Auto Scaling Group
resource "aws_autoscaling_group" "web-asg" {
  name = "web-asg"
  # Attach ASG to public subnets for external access
  # availability_zones = [ "ap-southeast-4a" ]
  launch_configuration = aws_launch_configuration.web-instance-lc.name
  min_size             = 1
  max_size             = 10
  desired_capacity     = 1
  #vpc_zone_identifier = aws_subnet.public_subnets[*].id
  vpc_zone_identifier = [
    for index, subnet in aws_subnet.public_subnets : subnet.id
  ]


  tag {
    key                 = "Name"
    value               = "Asg-web-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

