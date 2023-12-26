provider "aws" {
  region = "eu-central-1"
}

resource "aws_iam_role" "ec2_role" {
  name = "MyRoleForGetTag"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}