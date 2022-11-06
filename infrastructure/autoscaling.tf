resource "aws_launch_template" "webserver" {
  name = "jay101"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }


  iam_instance_profile {
    name = "LabInstanceProfile"
  }

  image_id = "ami-08e2d37b6a0129927"

  
  instance_type = "t2.micro"
  
  key_name = "vockey"


  vpc_security_group_ids = [aws_security_group.allow_http.id]


  user_data = filebase64("script/userdata.sh")
}

resource "aws_autoscaling_group" "jay101" {
  vpc_zone_identifier       = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.jay101.id
    version = "$Latest"
  }
  depends_on = [
    aws_nat_gateway.nat
  ]
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.jay101.id
  lb_target_group_arn    = aws_lb_target_group.jay101_target.arn
}
