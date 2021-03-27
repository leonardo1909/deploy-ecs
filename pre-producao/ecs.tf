resource "aws_ecs_cluster" "projeto-preprod-cluster" {
  name = "projeto-preprod-cluster"
  capacity_providers = [ "FARGATE" ]

  tags = {
    Name = "projeto-preprod-cluster"
  }
}