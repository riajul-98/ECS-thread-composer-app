# Creating a target group
resource "aws_lb_target_group" "project_alb_tg" {
  name        = "tf-example-lb-tg"
  target_type = "ip"
  port        = var.ecs_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  tags = {
    Name = "project_alb_tg"
  }
}

# Security Group for ALB with HTTP and HTTPS access
resource "aws_security_group" "alb_sg" {
  name        = "project_alb_sg"
  description = "Allow all incoming traffic on ports 443 and 80"
  vpc_id      = var.vpc_id
  tags = {
    Name = "project_alb_sg"
  }
  ingress {
    from_port   = var.http_ingress_ports
    to_port     = var.http_ingress_ports
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.https_ingress_ports
    to_port     = var.https_ingress_ports
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.SG_outgoing
  }
}

# Creating the ALB
resource "aws_lb" "project_alb" {
  name               = "project-alb"
  subnets            = var.pub_subnet_id
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  tags = {
    Name = "project_alb"
  }
}

# Creating HTTP listener for ALB
resource "aws_lb_listener" "project_alb_listeners" {
  load_balancer_arn = aws_lb.project_alb.arn
  protocol          = "HTTP"
  port              = var.listener_http_port
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project_alb_tg.arn
  }
}

# Creating HTTPS lsitener for ALB
resource "aws_lb_listener" "HTTPS" {
  load_balancer_arn = aws_lb.project_alb.arn
  port              = var.listener_https_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project_alb_tg.arn
  }
}
