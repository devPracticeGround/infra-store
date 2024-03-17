# locals

locals {
  tags = merge(
    var.tags,
    var.cluster_name != "" ? {
      "KubernetesCluster"                         = var.cluster_name
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
      "krmt.io/cluster"                           = var.cluster_name
    } : {},
  )
}