resource "aws_lb_target_group" "projeto-prod-tg" {
    name        = "projeto-prod-tg"
    port        = 80
    protocol    = "HTTP"
    target_type = "ip"
    vpc_id      = aws_vpc.projeto-prod-vpc.id

    tags = {
        Name = "projeto-prod-tg"
    }
}


resource "aws_lb" "projeto-prod-lb" {
    name               = "projeto-prod-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.projeto-prod-lb-sg.id]
    subnets            = [
        aws_subnet.projeto-prod-subnet-public.id,
        aws_subnet.projeto-prod-subnet-privada.id
    ]

    enable_deletion_protection = true

    # access_logs {
    #     bucket  = aws_s3_bucket.lb_logs.bucket
    #     prefix  = "test-lb"
    #     enabled = true
    # }

    tags = {
        Name = "projeto-prod-lb"
        Environment = "prod"
    }
}


resource "aws_lb_listener" "projeto-prod-https-listener" {
  load_balancer_arn = aws_lb.projeto-prod-lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificado_ssl

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.projeto-prod-tg.arn
  }
}



resource "aws_lb_listener" "projeto-prod-http-listener" {
    load_balancer_arn = aws_lb.projeto-prod-lb.arn
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