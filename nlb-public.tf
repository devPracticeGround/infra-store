# nlb_http_public

locals {
  nlb_http_public_tg_arns = [
    # module.nlb_http_public.http_tg_arn,
    # module.nlb_http_public.https_tg_arn,
  ]

  nlb_http_public_ports = [
    # 30080, 30443, 30200,
  ]
}

module "nlb_http_public" {
  source = "./http"

  name = format("%s-pub", var.cluster_name)

  cluster_name = var.cluster_name

  internal = false

  http_port        = 30080
  https_port       = 30443
  healthcheck_port = 30200

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  domain = "geunsam2.xyz"

  create_sg = true
  sg_id     = module.eks.node_security_group_id
  # deletion_protection = false

#   tags = module.labels.tags
}