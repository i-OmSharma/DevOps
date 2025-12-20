# output for count 

/*
output "ec2_public_ip" {
  value = aws_instance.my_instance[*].public_ip//--> [*]this menas for multiple   
}

output "ec2_public_dns" {
  value = aws_instance.my_instance.public_dns //--> this means single output
}


*/
# Output for for_each

output "ec2_public_ip" {
  value = {
    for key, value in aws_instance.my_instance :
    key => value.public_ip
  }
}
