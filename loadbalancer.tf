resource "aws_lb" "LB" {
  name               = "vinay-lb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.public.id, aws_subnet.public_2.id]
  security_groups    = [aws_security_group.SG.id]
}
resource "aws_lb_target_group" "TG" {
  name     = "Vinay-TargetGroup"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}
resource "aws_lb_target_group_attachment" "TGA" {
  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = aws_instance.ec2.id
  port             = 80

}