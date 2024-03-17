# variable

variable "name" {
  type = string
}

variable "domain" {
  type = string
}

variable "http_port" {
  type = number
}

variable "https_port" {
  type = number
}

variable "healthcheck_port" {
  type = number
}

variable "type" {
  type    = string
  default = "network"
}

variable "internal" {
  type    = bool
  default = true
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "cross_zone_load_balancing" {
  type    = bool
  default = true
}

variable "certificate_arn" {
  type    = string
  default = ""
}

variable "deregistration_delay" {
  type    = number
  default = 300
}

variable "cluster_name" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map
  default = {}
}