variable "name" {
  default = "dynamic-aws-creds-operator"
}

variable "region" {
  default = "ca-central-1"
}


variable "ttl" {
  default = "1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  default = ["ca-central-1a", "ca-central-1b"]
}