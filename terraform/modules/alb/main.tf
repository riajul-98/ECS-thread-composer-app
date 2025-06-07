resource "aws_lb_target_group" "project_alb_tg" {
  name     = "tf-example-lb-tg"
  target_type = "ip"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    Name = "project_alb_tg"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "project_alb_sg"
  description = "Allow all incoming traffic on ports 443 and 80"
  vpc_id      = var.vpc_id
  tags = {
    Name = "project_alb_sg"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "project_alb" {
  name               = "project-alb"
  subnets            = var.pub_subnet_id
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  tags = {
    Name = "project_alb"
  }
}

resource "aws_lb_listener" "project_alb_listeners" {
  load_balancer_arn = aws_lb.project_alb.arn
  protocol          = "HTTP"
  port              = "80"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project_alb_tg.arn
  }
}

resource "aws_lb_listener" "HTTPS" {
  load_balancer_arn = aws_lb.project_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project_alb_tg.arn
  }
}
