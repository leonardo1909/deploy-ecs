# #Criado manualmente e importado para o terraform
# resource "aws_route53_zone" "arbache-dev-zone" {
#   name = "arbache.dev.br"
# }

# #Necessario para ativar o certificado.
# resource "aws_route53_record" "projeto-homolog-record" {
#     for_each = {
#         for dvo in aws_acm_certificate.projeto-homolog-certificate.domain_validation_options : dvo.domain_name => {
#             name   = dvo.resource_record_name
#             record = dvo.resource_record_value
#             type   = dvo.resource_record_type
#         }
#     }

#     allow_overwrite = true
#     name            = each.value.name
#     records         = [each.value.record]
#     ttl             = 60
#     type            = each.value.type
#     zone_id         = aws_route53_zone.arbache-dev-zone.zone_id
# }