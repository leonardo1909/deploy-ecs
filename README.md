# Deploy ECS
<div align="right">Ultima atualização: 27/03/2021</div>
<div align="right">Por: Leonardo José</div>

## Requisitos
- Docker
- Conta AWS

## Ambientes
O projeto comtempla a criação, individualmente, de 3 ambientes na AWS utilizando ECS FARGATE para deploy de aplicações web(porta 80 e 443).

Os nomes dos ambientes são os mesmos nomes das pasta do projeto, respectivamente:
- homolog
- pre-producao
- producao

Para abrir a CLI de um ambiente:

`make terraform ambiente={{nome_do_ambiente}}`

## Processos "Automatizados"
O projeto contempla a criação dos seguintes serviços e suas dependências:
- VPC
- Subredes pública e privada
- Grupos de segurança
- Grupos de destino
- Load balance
- Load balance listeners
- Cluste ECS FARGATE
- RDS (db.t2.micro)

## Processos Manuais
Alguns processos manuais devem ser feitos para um pleno funcionamento, são eles:
- Criar o bucket especificado no `main.tf` de cada ambiente para salvar os estados do ambiente.
- Registrar e ativar um certificado SSL, de preferência utilizando AWS ACM.
- Registrar um dominio, de preferência no Route53, e "linkar" com o loadbalance
- Registrar uma "task-definition" com os containers e configuração da sua aplicação.
- Registrar um "service" no cluster para iniciar a aplicação e, em seguida, automatizar o deploy da aplicação(deploy automático não está no escopo desse projeto).

## Observações
- Os passos 1 e 2 dos "Processos manuais" devem ser executados antes de criar a infra. Sem o passo 2 não conseguimos lincar o certificado ssl ao listener do loadbalancer na porta 443.

- Por hora, os arquivos de makefile dentro das pastas dos ambientes servem apenas como um "lembrete" dos comandos mais comuns a serem utilizado dentro da CLI de cada ambiente pois, o makefile não funciona dentro do container do terraform:light

- O acesso ao banco de dados por fora da aplicação varia de ambiente para ambiente. Em homolog e pre-produção é possível acessar de forma remota e em produção o acesso é feito apenas dentro da VPC.

## Resultado Esperado
Como resultado final dos processos automatizados e manuais é esperado que se tenha uma aplicação web registrada em um dominio especificado respondendo a requisiçoes https e redirecionando automaticamente requisições http para https.