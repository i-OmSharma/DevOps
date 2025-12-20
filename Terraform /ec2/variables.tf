variable "ec2_instance_type" {
  default = "t2.micro"
  type = string
}

variable "ec2_default_root_storage_size" {
  default = 9
  type = number
}

variable "ec2_root_storage_type" {
  default = "gp3"
  type = string
}

variable "ec2_ami_id" {
  default = "ami-02b8269d5e85954ef"
  type = string
}

variable "env" {
  default = "prd"
  type = string
}

