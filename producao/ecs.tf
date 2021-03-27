resource "aws_ecs_cluster" "projeto-prod-cluster" {
  name = "projeto-prod-cluster"
  capacity_providers = [ "FARGATE" ]

  tags = {
    Name = "projeto-prod-cluster"
  }
}