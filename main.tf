provider "aws" {
  region = "<AWS_REGION>"
}

resource "aws_ecr_repository" "app" {
  name = "demo-app"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "demo-app"
  container_definitions    = jsonencode([{
    name                    = "demo-app"
    image                   = aws_ecr_repository.app.repository_url
    essential               = true
    portMappings            = [{
      containerPort         = 3000
      hostPort              = 3000
    }]
  }])
  memory                   = 512
  cpu                      = 256
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_service" "app" {
  name            = "demo-app"
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1

  network_configuration {
    subnets         = ["<SUBNET_ID>"]
    security_groups = ["<SECURITY_GROUP_ID>"]
  }

  load_balancer {
    target_group_arn = "<TARGET_GROUP_ARN>"
    container_name   = "demo-app"
    container_port   = 3000
  }
}
