terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

locals {
  base_ingress_rules = [
    {
      description = "Kubernetes API access"
      from_port   = 6443
      to_port     = 6443
      protocol    = "tcp"
    },
    {
      description = "etcd access"
      from_port   = 2379
      to_port     = 2379
      protocol    = "tcp"
    },
    {
      description = "etcd access"
      from_port   = 2380
      to_port     = 2380
      protocol    = "tcp"
    },
    {
      description = "Kubelet API access"
      from_port   = 10250
      to_port     = 10250
      protocol    = "tcp"
    },
    {
      description = "NodePort Services"
      from_port   = 30000
      to_port     = 32767
      protocol    = "tcp"
    },
    {
      description = "CoreDNS"
      from_port   = 53
      to_port     = 53
      protocol    = "udp"
    }
  ]
}

resource "aws_security_group" "this" {
  name        = var.name
  description = "Security group for ${var.name}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.base_ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
