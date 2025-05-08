/* Load-balancer creation */

resource "aws_lb" "load_balancer" {
  name = var.load_balancer
  internal =  false  ## public load balancer 
  load_balancer_type = "application"
  security_groups = [ var.security_group ]
  subnets = var.subnet_id
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name = "web-lb-target-group"
  port = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = var.vpc_id

  health_check {
    path = "/"
  }
}