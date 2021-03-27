resource "aws_lb_target_group" "projeto-preprod-tg" {
    name        = "projeto-preprod-tg"
    port        = 80
    protocol    = "HTTP"
    target_type = "ip"
    vpc_id      = aws_vpc.projeto-preprod-vpc.id

    tags = {
        Name = "projeto-preprod-tg"
    }
}


resource "aws_lb" "projeto-preprod-lb" {
    name               = "projeto-preprod-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.projeto-preprod-lb-sg.id]
    subnets            = [
        aws_subnet.projeto-preprod-subnet-public.id,
        aws_subnet.projeto-preprod-subnet-privada.id
    ]

    enable_deletion_protection = true

    # access_logs {
    #     bucket  = aws_s3_bucket.lb_logs.bucket
    #     prefix  = "test-lb"
    #     enabled = true
    # }

    tags = {
        Name = "projeto-preprod-lb"
        Environment = "preprod"
    }
}


resource "aws_lb_listener" "projeto-preprod-https-listener" {
  load_balancer_arn = aws_lb.projeto-preprod-lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificado_ssl

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.projeto-preprod-tg.arn
  }
}



resource "aws_lb_listener" "projeto-preprod-http-listener" {
    load_balancer_arn = aws_lb.projeto-preprod-lb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type = "redirect"

        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}