resource "aws_db_subnet_group" "projeto-prod-sng" {
    name       = "projeto-prod-sng"
    subnet_ids = [
        aws_subnet.projeto-prod-subnet-public.id,
        aws_subnet.projeto-prod-subnet-privada.id
    ]

    tags = {
        Name = "projeto-prod-sng"
    }
}


resource "aws_db_instance" "projeto-prod-db" {
    allocated_storage = 10
    engine = "postgres"
    engine_version = "12.5"
    instance_class = "db.t2.micro"
    name = var.rds_nome
    identifier = "projeto-prod-db"
    username = var.rds_username
    password = var.rds_senha
    skip_final_snapshot  = true
    db_subnet_group_name = aws_db_subnet_group.projeto-prod-sng.id
    availability_zone = "us-east-2a"
    publicly_accessible = false
    vpc_security_group_ids = [
        aws_security_group.projeto-prod-db-sg.id
    ]

    tags = {
        Name = "projeto-prod-db"
    }
}