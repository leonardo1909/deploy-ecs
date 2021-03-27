resource "aws_db_subnet_group" "projeto-homolog-sng" {
    name       = "projeto-homolog-sng"
    subnet_ids = [
        aws_subnet.projeto-homolog-subnet-public.id,
        aws_subnet.projeto-homolog-subnet-privada.id
    ]

    tags = {
        Name = "projeto-homolog-sng"
    }
}


resource "aws_db_instance" "projeto-homolog-db" {
    allocated_storage = 10
    engine = "postgres"
    engine_version = "12.5"
    instance_class = "db.t2.micro"
    name = var.rds_nome
    identifier = "projeto-homolog-db"
    username = var.rds_username
    password = var.rds_senha
    skip_final_snapshot  = true
    db_subnet_group_name = aws_db_subnet_group.projeto-homolog-sng.id
    publicly_accessible = true
    vpc_security_group_ids = [
        aws_security_group.projeto-homolog-db-sg.id
    ]

    tags = {
        Name = "projeto-homolog-db"
    }
}