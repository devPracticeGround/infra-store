# data "aws_acm_certificate" "default" {
#   domain      = var.domain
#   types       = ["AMAZON_ISSUED"]
#   most_recent = true
# }

# locals {
#   certificate_arn = var.certificate_arn != "" ? var.certificate_arn : data.aws_acm_certificate.default.arn
# }

resource "aws_lb" "default" {
  name                             = var.name
  internal                         = var.internal
  load_balancer_type               = var.type
  enable_deletion_protection       = var.deletion_protection
  enable_cross_zone_load_balancing = var.cross_zone_load_balancing
  subnets                          = var.subnet_ids

  tags = merge(
    local.tags,
    {
      "Name" = var.name
    },
  )
}

resource "aws_lb_target_group" "http" {
  name        = "${var.name}-http"
  target_type = "instance"
  port        = var.http_port
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  health_check {
    path = "/healthz"
    port = var.healthcheck_port
  }
  deregistration_delay = var.deregistration_delay

  tags = merge(
    local.tags,
    {
      "Name" = "${var.name}-http"
    },
  )
}

resource "aws_lb_target_group" "https" {
  name        = "${var.name}-https"
  target_type = "instance"
  port        = var.https_port
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  health_check {
    path = "/healthz"
    port = var.healthcheck_port
  }
  deregistration_delay = var.deregistration_delay

  tags = merge(
    local.tags,
    {
      "Name" = "${var.name}-https"
    },
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.default.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.default.arn
#   port              = "443"
#   protocol          = "TLS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = local.certificate_arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.https.arn
#   }
# }