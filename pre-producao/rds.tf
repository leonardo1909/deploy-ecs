resource "aws_db_subnet_group" "projeto-preprod-sng" {
    name       = "projeto-preprod-sng"
    subnet_ids = [
        aws_subnet.projeto-preprod-subnet-public.id,
        aws_subnet.projeto-preprod-subnet-privada.id
    ]

    tags = {
        Name = "projeto-preprod-sng"
    }
}


resource "aws_db_instance" "projeto-preprod-db" {
    allocated_storage = 10
    engine = "postgres"
    engine_version = "12.5"
    instance_class = "db.t2.micro"
    name = var.rds_nome
    identifier = "projeto-preprod-db"
    username = var.rds_username
    password = var.rds_senha
    skip_final_snapshot  = true
    db_subnet_group_name = aws_db_subnet_group.projeto-preprod-sng.id
    publicly_accessible = true
    vpc_security_group_ids = [
        aws_security_group.projeto-preprod-db-sg.id
    ]

    tags = {
        Name = "projeto-preprod-db"
    }
}