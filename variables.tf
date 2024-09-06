variable "create_sg" {}

# variable "count_instance" {}


#EC2 Variables
variable "ami_id" {}

variable "region" {}

variable "instance_type" {}
variable "key_name" {}
variable "machine_name" {}
variable "backend-bucket" {}
variable "backend-key" {}
variable "vpc_id" { default = "vpc-0cc7e1e8d0e236d78" }
variable "default_sg" {}
variable "created_by" {}
variable "user_data" {}

variable "tags" {
  type = map(string)
}
variable "count_instance" {
  description = "Number of EC2 instances to create"
  type        = number
}
# variable "ssh_key_address" {}

#Security Group variables
variable "sg_name" {}
variable "sg_description" {}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rule" {
  description = "List of egress rule"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}


variable "subnets" {
  type = list(string)
}
