# This will be used in ECS Service declaration
resource "aws_alb" "application-load-balancer" {
  count = var.ecs-enabled ? 1 :0

  name                = "codehunters-alb-ecs"
  internal            = false
  load_balancer_type  = "application"
  subnets             = aws_subnet.public-subnets.*.id
  security_groups     = [ aws_security_group.subnet-security-group[0].id ]

  tags = {
    Name        = "ALB"
  }
}

resource "aws_lb_target_group" "application-load-balancer-target-group" {
  count = var.ecs-enabled ? 1 :0

  name        = "ch-alb-target-group"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc[0].id

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/actuator/health"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "ALB Target Group"
  }
}

resource "aws_lb_listener" "listener" {
  count = var.ecs-enabled ? 1 :0

  load_balancer_arn = aws_alb.application-load-balancer[0].id
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application-load-balancer-target-group[0].id
  }
}