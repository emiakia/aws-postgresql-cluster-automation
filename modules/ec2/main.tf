
resource "aws_instance" "ec2" {
  count           = var.count_instance
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  # security_groups = var.security_groups
  vpc_security_group_ids = var.security_groups
  iam_instance_profile = var.ec2_role  # Attach IAM role to the instance
  # user_data = var.user_data
  # tags = var.tags
  user_data = file(var.ec2_user_data[count.index])
  tags = merge(
    var.tags,
    {
      Name = "${var.machine_name}-${count.index}"
    }
  )


  # provisioner "remote-exec" {
  #   inline = [
  #     'curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"',
  #     'apt install zip',
  #     'unzip awscliv2.zip',
  #     'sudo ./aws/install',

  #     # Fetch all instance details
  #     "aws ec2 describe-instances --query 'Reservations[*].Instances[*].{ID:InstanceId,Name:Tags[?Key==`Name`].Value|[0],PrivateIP:PrivateIpAddress,PublicIP:PublicIpAddress}' --output text > /home/ec2-user/all_instances.txt"
  #   ]

  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu" # Replace with your SSH user
  #     private_key = file(var.ssh_key_address) # Replace with the path to your private key
  #     host        = self.public_ip
  #   }
  # }
}