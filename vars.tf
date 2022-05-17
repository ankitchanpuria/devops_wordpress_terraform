variable "aws_access_key" {
    default = "ASIAWALJACTLPV47M5LL"
}
variable "aws_secret_key" {
    default = "JKikWr78tnmgazfWrzfP/o5jqO/Hwz8v4WgvocCE"
}
variable "aws_key_path" {
    default = "/home/ankitchanpuriag/project_2/project_2.pem"
}
variable "aws_key_name" {
    default = "project_2.pem"
}
variable "aws_security_token" {
    default = "FwoGZXIvYXdzEPn//////////wEaDN9gc9qcUcvOy3i2myK5AaHaiOgPmTuWyChOd/A6Eeyf5iXD/JKokVSLZHm885WScGkxi7usUVOgN1hhGj4M4SH3ZWuxQuKvMmMlX4emUXtDWv0NTYpQp9/TIzybbFwz0BqW1ep5NnNVKp3Knlc1frKy2poC/A1pPokQ+1q5gw92zU7li+CgP3asERx+T03QOorY4ewKmInKpN/JnaffnzWalPU1Kl9a2E6Rjy6FqI3x1BPKRHUB5exGGwe3bg9ykHbedBfny+wgKKyHj5QGMi0XGvVh+DSZqa1Kg5Gqh20ai0z4MLl9dCcXRgexkF8WPSHjIv4REjorc9wxiQY="
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-east-1 = "ami-09e67e426f25ce0d7"
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}
