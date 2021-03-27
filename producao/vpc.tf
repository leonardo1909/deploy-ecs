resource "aws_vpc" "projeto-prod-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"

    tags = {
        Name = "projeto-prod-vpc"
    }
}

resource "aws_subnet" "projeto-prod-subnet-public" {
    vpc_id = aws_vpc.projeto-prod-vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = "true" //subnet publica
    availability_zone = "us-east-2a"

    tags = {
        Name = "projeto-prod-subnet-public"
    }
}

resource "aws_subnet" "projeto-prod-subnet-privada" {
    vpc_id = aws_vpc.projeto-prod-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "false" //subnet privada
    availability_zone = "us-east-2b"

    tags = {
        Name = "projeto-prod-subnet-privada"
    }
}

resource "aws_internet_gateway" "projeto-prod-igw" {
    vpc_id = aws_vpc.projeto-prod-vpc.id

    tags = {
        Name = "projeto-prod-igw"
    }
}

resource "aws_route_table" "projeto-prod-public-rt" {
    vpc_id = aws_vpc.projeto-prod-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.projeto-prod-igw.id
    }

    tags = {
        Name = "projeto-prod-public-rt"
    }
}

#associa RT a Subnet publica
resource "aws_route_table_association" "projeto-prod-rt-public-subnet" {
    subnet_id = aws_subnet.projeto-prod-subnet-public.id
    route_table_id = aws_route_table.projeto-prod-public-rt.id
}


#SG utilizado pelo loadbalance. Permite acesso por 80 e 443
resource "aws_security_group" "projeto-prod-lb-sg" {
    vpc_id = aws_vpc.projeto-prod-vpc.id

    egress  {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress  {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress  {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "projeto-prod-sg"
    }
}


#SG utilizado pela aplicação. Permite acesso pela porta 8000
resource "aws_security_group" "projeto-prod-app-sg" {
    vpc_id = aws_vpc.projeto-prod-vpc.id

    egress  {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress  {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "projeto-prod-app-sg"
    }
}


#SG utilizado pelo banco de dados.
#Permite acesso de qualquer lugar pela porta 5432
resource "aws_security_group" "projeto-prod-db-sg" {
    vpc_id = aws_vpc.projeto-prod-vpc.id

    ingress  {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "projeto-prod-db-sg"
    }
}