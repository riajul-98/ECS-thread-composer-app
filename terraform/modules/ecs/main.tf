# Creating Security Group for ECS tasks
resource "aws_security_group" "ecs_sg" {
  name        = "ecs_sg"
  description = "Allow HTTP traffic from the load balancer"
  vpc_id      = var.vpc_id
  ingress {
    from_port       = var.ecs_port
    to_port         = var.ecs_port
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.SG_outgoing
  }
}

# Provisioning ECS Cluster
resource "aws_ecs_cluster" "project_cluster" {
  name = "project_cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# ECS Task Definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "project_task_definition"
  execution_role_arn       = var.iam_role_arn
  requires_compatibilities = [var.ecs_launch_type]
  network_mode             = "awsvpc"
  cpu                      = var.number_of_cpu
  memory                   = var.mem
  container_definitions = jsonencode([
    {
      name  = var.container_name
      image = var.container_image
      portMappings = [
        {
          containerPort = var.ecs_port
          hostPort      = var.ecs_port
          protocol      = "tcp"
        }
      ]
    }
  ])
  tags = {
    Name = "project_task_definition"
  }
}

# ECS service
resource "aws_ecs_service" "ecs_project_service" {
  name            = "ecs_project_service"
  cluster         = aws_ecs_cluster.project_cluster.id
  launch_type     = var.ecs_launch_type
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.desired_number
  network_configuration {
    subnets          = var.priv_sub_id
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_sg.id]
  }
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.ecs_port
  }
  tags = {
    Name = "ecs_project_service"
  }
  depends_on = [
    var.http_listener_arn,
    var.https_listener_arn
  ]
}