resource "aws_ecs_cluster" "main" {
  name = "threatmod-cluster"
}

resource "aws_iam_role" "ecs_execution" {
  name = "ecsTaskExecutionRoleTerraform"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "threatmod-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name  = "threatmod-container"
      image = "${var.repository_url}:latest"

      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "threatmod-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

 network_configuration {
  subnets          = var.private_subnet_ids
  security_groups  = [var.ecs_sg_id]
  assign_public_ip = true
}

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "threatmod-container"
    container_port   = 3000
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_execution
  ]
}