output "cluster_name" {
  value = aws_eks_cluster.test.id
}

output "endpoint" {
  value = aws_eks_cluster.test.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.test.certificate_authority[0].data
}