# output

output "http_port" {
  value = var.http_port
}

# output "https_port" {
#   value = var.https_port
# }

output "healthcheck_port" {
  value = var.healthcheck_port
}

output "http_tg_arn" {
  value = aws_lb_target_group.http.arn
}

# output "https_tg_arn" {
#   value = aws_lb_target_group.https.arn
# }

output "dns_name" {
  value = aws_lb.default.dns_name
}

output "zone_id" {
  value = aws_lb.default.zone_id
}

output "http_lb_listener_arn" {
  value = aws_lb_listener.http.arn
}

# output "https_lb_listener_arn" {
#   value = aws_lb_listener.https.arn
# }