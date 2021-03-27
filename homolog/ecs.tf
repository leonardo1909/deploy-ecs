resource "aws_ecs_cluster" "projeto-homolog-cluster" {
  name = "projeto-homolog-cluster"
  capacity_providers = [ "FARGATE" ]

  tags = {
    Name = "projeto-homolog-cluster"
  }
}