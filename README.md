# AWS EC2 PostgreSQL Cluster with Ansible Automation

## Project Overview

This project automates the creation of a PostgreSQL cluster on AWS using Terraform and Ansible. It provisions two EC2 instances that are automatically configured as a primary and standby PostgreSQL database, using appropriate security groups for SSH access and database traffic. The entire process is designed to be executed with minimal user intervention once configured.

Each EC2 instance retrieves its corresponding playbook (either for primary or standby PostgreSQL installation) from a specified repository, ensuring that both the primary and standby databases are configured properly.

The project uses the AWS CLI and a pre-defined IAM role to allow each instance to retrieve the IP address of the other. This is essential for configuring streaming replication between the two instances.

## Project Workflow

1. **Infrastructure Setup with Terraform**:
    - Terraform provisions two EC2 instances in the same AWS VPC.
    - A security group is created to allow SSH (port 22) and PostgreSQL (port 5432) traffic between the instances.
    - Each instance is tagged and assigned an IAM role, which provides it with the necessary permissions to query AWS for the other instance's IP address.

2. **Instance Bootstrapping**:
    - After creation, each EC2 instance automatically installs the AWS CLI.
    - Using the pre-assigned IAM role, the instances retrieve each other's private IP addresses.
    - These IP addresses are then used to configure PostgreSQL replication (primary and standby).

3. **PostgreSQL Installation with Ansible**:
    - Each EC2 instance fetches its respective Ansible playbook from the repository.
    - The primary instance installs and configures PostgreSQL as the main database server.
    - The secondary instance (standby) installs PostgreSQL and configures itself as a standby server using streaming replication from the primary instance.

4. **Automation with Playbooks**:
    - Ansible automates the entire installation and configuration process for both the primary and standby instances.
    - The playbooks handle the installation, configuration, and synchronization between the two PostgreSQL servers.

## Prerequisites

- **Terraform**: Ensure Terraform is installed and properly configured for AWS.
- **Ansible**: Ansible should be installed on the machine from which you will run this project.
- **AWS IAM Role**: A pre-existing IAM role with the `AmazonEC2ReadOnlyAccess` policy attached. This role allows the EC2 instances to query information about each other.
- **SSH Key**: A valid SSH key pair for accessing the EC2 instances.
- **AWS Credentials**: AWS credentials should be properly configured on your local machine or CI/CD pipeline.

## Usage

1. Clone this repository:
    ```bash
    git clone https://github.com/your-repo/postgresql-cluster-aws.git
    cd postgresql-cluster-aws
    ```

2. Customize the variables for your AWS setup:
    - Update the `terraform.tfvars` or `vars.tf` with your specific configuration (e.g., `ami_id`, `vpc_id`, `instance_type`, etc.).
  
3. Initialize and apply the Terraform configuration:
    ```bash
    terraform init
    terraform apply
    ```

4. After the infrastructure is provisioned, Terraform outputs the instance details. The EC2 instances will automatically configure PostgreSQL and set up replication based on the playbooks fetched from the repository.

## Security Groups

- **Ingress Rules**:
    - Allow SSH access on port 22.
    - Allow PostgreSQL traffic on port 5432 between the two instances.

- **Egress Rules**:
    - Allow all outbound traffic for communication with other AWS services and for the PostgreSQL replication setup.

## Notes

- No manual configuration is required on the EC2 instances once the Terraform script is applied.
- Ensure that your IAM role has sufficient permissions to query instance information and allow communication between the instances.
- The playbooks will configure PostgreSQL and replication based on each instance’s role (primary or standby).

## Customization

- **Instance Count**: You can scale the number of EC2 instances by modifying the `count_instance` variable in the Terraform configuration.
- **User Data Scripts**: Customize the user data scripts if additional bootstrapping is required beyond PostgreSQL and Ansible installation.
