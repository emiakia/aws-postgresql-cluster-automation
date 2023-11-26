provider "aws" {
  region = "eu-central-1"
}
module "security_group" {
  source = "./modules/security_group"
  # count = 1
  name          = var.sg_name
  description   = var.sg_description
  vpc_id        = var.vpc_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rule
  tags          = var.tags
}


# # IAM Role
# resource "aws_iam_role" "ec2_role" {
#   name = "MyRoleForGetTag"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = "sts:AssumeRole"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       }
#     ]
#   })
# }


# resource "aws_iam_instance_profile" "ec2_instance_profile" {
#   name = "MyInstanceProfileForEC2"
#   role = aws_iam_role.ec2_role.name
#   depends_on = [aws_iam_role.ec2_role]
# }

# resource "aws_iam_role_policy_attachment" "ec2_role_policy" {
#   role       = aws_iam_role.ec2_role.name
#   policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
#   depends_on = [aws_iam_instance_profile.ec2_instance_profile]  
# }


module "ec2" {
  source        = "./modules/ec2"
  ami           = var.ami_id
  instance_type = var.instance_type

  security_groups = var.create_sg ? [module.security_group.id] : [var.default_sg]
  key_name        = var.key_name
  count_instance  = var.count_instance
  machine_name    = var.machine_name
  tags            = var.tags
  created_by      = var.created_by
  ec2_role        = "MyRoleForGetTag" # Pass the IAM role to the module

  # user_data = var.user_data
  # user_data = file("./bash/bash-postgres-${count.index}.sh")
  ec2_user_data = [for i in range(var.count_instance) : "./bash/bash-postgres-${i}.sh"]
  # ssh_key_address = var.ssh_key_address
}



