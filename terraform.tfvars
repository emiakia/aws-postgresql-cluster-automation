
# create_sg = false
create_sg      = true
count_instance = 2
# AWS Provider Configuration
region = "eu-central-1"


# Security Group Variables
sg_name        = "SG_POSTGRES_SSH"
sg_description = "Allow SSH and HTTP inbound traffic"
vpc_id         = "vpc-0cc7e1e8d0e236d78"

ingress_rules = [
  {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "DB"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
egress_rule = [
  {
    description = "All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
tags = {
  "Pupose" = "Just For Test By Terraform"
  "Name"   = "my-security-group"
}

#aws Instance Variables

# ami_id        = "ami-071878317c449ae48" #amazon
ami_id        = "ami-0e04bcbe83a83792e"  #ubuntu
instance_type = "t2.micro"
key_name      = "devKey"

machine_name = "Emran"
subnets      = ["subnet-093f0311edbfe83fb", "subnet-0a21b416cfd5ab2a3", "subnet-04f0df809d5307602"]
default_sg   = "sg-0a28a74fed00b7df4"

backend-bucket = "dev-terraform-tutorial"
backend-key    = "build/airflow/terraform.tfstate"
created_by     = "Terraform"
user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd
            systemctl start httpd
            systemctl enable httpd
            echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
            EOF


# ssh_key_address =  = "C:\Users\User\.ssh\devKey.pem"
