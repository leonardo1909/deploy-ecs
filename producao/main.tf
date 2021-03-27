terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        }
    }

    backend "s3" {
        # Lembre de trocar o bucket para o seu, não pode ser o mesmo nome
        bucket = "projeto-prod-tfstates"
        key    = "projeto-prod.tfstate"
        region = var.regiao_projeto
    }
}

provider "aws" {
  region  = var.regiao_projeto
}