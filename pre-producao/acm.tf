# resource "aws_acm_certificate" "projeto-preprod-certificate" {
#   domain_name       = "projeto-preprod.arbache.dev.br"
#   validation_method = "DNS"

#   tags = {
#     Environment = "preprod"
#     Name = "projeto-preprod-certificate"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }


# resource "aws_acm_certificate_validation" "projeto-preprod-validation" {
#     certificate_arn         = aws_acm_certificate.projeto-preprod-certificate.arn
#     validation_record_fqdns = [for record in aws_route53_record.projeto-preprod-record : record.fqdn]
# }