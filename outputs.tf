output "app_url" {
  value = aws_ecs_service.app.load_balancers[0].dns_name
}
