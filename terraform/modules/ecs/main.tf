resource "aws_security_group" "ecs_sg" {
  name        = "ecs_sg"
  description = "Allow HTTP traffic from the load balancer"
  vpc_id      = var.vpc_id
  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_cluster" "project_cluster" {
  name = "project_cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family             = "project_task_definition"
  execution_role_arn = var.iam_role_arn
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  container_definitions = jsonencode([
    {
      name  = "threat-composer"
      image = var.container_image
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
    }
  ])
  tags = {
    Name = "project_task_definition"
  }
}

resource "aws_ecs_service" "ecs_project_service" {
  name            = "ecs_project_service"
  cluster         = aws_ecs_cluster.project_cluster.id
  launch_type = "FARGATE"
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 2
  network_configuration {
    subnets          = var.priv_sub_id
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_sg.id]
  }
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "threat-composer"
    container_port   = 3000
  }
  tags = {
    Name = "ecs_project_service"
  }
  depends_on = [
    var.http_listener_arn,
    var.https_listener_arn
  ]
}