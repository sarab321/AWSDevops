################# Project Variables ################
####################################################

variable "environment" {
    description = "This represent the environment"
    default = "dev"
}

variable "env_main" {
    description = "This represent the environment"
    default = "nonprod"
}



################# EC2 Variables #####################
#####################################################

variable "aws_ec2_ami" {
    description = "This represent the aws ec2 ami"
    default = "ami-04d29b6f966df1537"
}

variable "aws_ec2_instance_type" {
    description = "This represent the aws ec2 instance type"
    default = "t2.micro"
}

############## Security Group Variable #################
########################################################

variable "https_port" {
    description = "This represent the HTTPS port"
    default = "443"
}

variable "tcp_port" {
    description = "This represent the TCP port"
    default = "22"
}

variable "tcp_protocol" {
    description = "This represent the TCP protocol"
    default = "tcp"
}

variable "egress_cidr_block" {
    type = list(string)
    description = "This represent the Egress CIDR block"
    default = ["0.0.0.0/0"]
}

################ Networking Variables #####################
###########################################################

variable "vpc_cidr_block" {
    description = "This represent the VPC CIDR block"
    default = "10.0.0.0/16"
}

variable "instance_tenancy" {
    description = "A tenancy option for instances launched into the VPC"
    default = "default"
}

variable "public_subnet_cidr_block" {
    description = "This represent the VPC CIDR block"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr_block" {
    description = "This represent the VPC CIDR block"
    default = "10.1.0.0/24"
}

variable "route_table_igw_cidr_block" {
    description = "This represent the IGW Route table CIDR block"
    default = "0.0.0.0/0"
}
