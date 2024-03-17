# security_group

variable "create_sg" {
  type    = bool
  default = true
}

variable "sg_id" {
  type    = string
  default = ""
}

variable "sg_cidr_blocks" {
  type    = list(string)
  default = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "healthcheck_port" {
  count = var.create_sg ? var.sg_id == "" ? 0 : 1 : 0

  description       = "${var.name} / ${var.healthcheck_port} - healthcheck port"
  type              = "ingress"
  from_port         = var.healthcheck_port
  to_port           = var.healthcheck_port
  protocol          = "TCP"
  cidr_blocks       = var.sg_cidr_blocks
  security_group_id = var.sg_id
}

resource "aws_security_group_rule" "http_port" {
  count = var.create_sg ? var.sg_id == "" ? 0 : 1 : 0

  description       = "${var.name} / ${var.http_port} - http port"
  type              = "ingress"
  from_port         = var.http_port
  to_port           = var.http_port
  protocol          = "TCP"
  cidr_blocks       = var.sg_cidr_blocks
  security_group_id = var.sg_id
}

resource "aws_security_group_rule" "https_port" {
  count = var.create_sg ? var.sg_id == "" ? 0 : 1 : 0

  description       = "${var.name} / ${var.https_port} - https port"
  type              = "ingress"
  from_port         = var.https_port
  to_port           = var.https_port
  protocol          = "TCP"
  cidr_blocks       = var.sg_cidr_blocks
  security_group_id = var.sg_id
}

resource "aws_security_group_rule" "http_all" {
  count = var.create_sg ? var.sg_id == "" ? 0 : var.internal ? 0 : 1 : 0

  description       = "${var.name} / ${var.http_port} - http all"
  type              = "ingress"
  from_port         = var.http_port
  to_port           = var.http_port
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.sg_id
}

resource "aws_security_group_rule" "https_all" {
  count = var.create_sg ? var.sg_id == "" ? 0 : var.internal ? 0 : var.http_port != var.https_port ? 1 : 0 : 0

  description       = "${var.name} / ${var.https_port} - https all"
  type              = "ingress"
  from_port         = var.https_port
  to_port           = var.https_port
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.sg_id
}