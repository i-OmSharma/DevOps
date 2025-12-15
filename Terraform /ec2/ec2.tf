# key pair


resource "aws_key_pair" "my_key" {
  key_name = "tera-key"
  public_key = file("tera-key.pub")
}

# VPS & Security group

resource "aws_default_vpc" "default" {
  
}



resource "aws_security_group" "my_sec_group" {
    name = "automate_secGroup"
    description = "This will add a TF generate Security Group"
    vpc_id = aws_default_vpc.default.id # interpolation 


    # inbound rules
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH open"
    }

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP open"
    }

    ingress{
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Custom port open"
    }


    # Outbound rules
    egress{ 
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "All access open"
    }

    tags = {
        Name = "automate_secGroup"
    }
  
}

# ec2

resource "aws_instance" "my_instance" {
   key_name = aws_key_pair.my_key.key_name
   security_groups = [aws_security_group.my_sec_group.name]
   instance_type = var.aws_instance // default u can write "t2.micro"
   ami = var.ec2_ami_id #ubuntu "ami id of the os"

   root_block_device {
     volume_size = var.ec2_root_storage_size // dafault size 8
     volume_type = var.ec2_root_storage_type //default "gp3"
   }

   tags = {
     Name = "IAC ec2"
   }
}


