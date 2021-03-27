# resource "aws_acm_certificate" "projeto-homolog-certificate" {
#   domain_name       = "projeto-homolog.arbache.dev.br"
#   validation_method = "DNS"

#   tags = {
#     Environment = "homolog"
#     Name = "projeto-homolog-certificate"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }


# resource "aws_acm_certificate_validation" "projeto-homolog-validation" {
#     certificate_arn         = aws_acm_certificate.projeto-homolog-certificate.arn
#     validation_record_fqdns = [for record in aws_route53_record.projeto-homolog-record : record.fqdn]
# }