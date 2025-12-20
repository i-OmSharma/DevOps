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
  for_each = tomap({
    IAC-ec2-micro = "t2.micro"
    IAC-ec2-medium = "t2.medium "
  }) #--> Meta args
# ----------------------------------------------------
  # count = 2 #--> Meta args
# ----------------------------------------------------

   key_name = aws_key_pair.my_key.key_name
   vpc_security_group_ids = [aws_security_group.my_sec_group.id]
   instance_type = each.value  // var.aws_instance // default u can write "t2.micro"
   ami = var.ec2_ami_id #ubuntu "ami id of the os"
   user_data = file("install_nginx.sh")

   depends_on = [ aws_default_vpc.default, aws_default_vpc.default, aws_security_group.my_sec_group ]

   root_block_device {
     volume_size =  var.env == "prd" ? 20 : var.ec2_default_root_storage_size // var.ec2_root_storage_size // dafault size 8
     volume_type = var.ec2_root_storage_type //default "gp3"
   }

   tags = {
     Name =   each.key // "IAC ec2"
   }
}


resource "aws_instance" "IAC_ec2_v2" {
  ami = "unknown"
  instance_type = "unknown"
}