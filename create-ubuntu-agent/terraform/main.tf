provider "aws" {
  region = "ap-southeast-1"
}

resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name = "agent-key.pub"
  public_key = tls_private_key.rsa_key.public_key_openssh
}

resource "local_file" "ssh_private_key" {
  content = tls_private_key.rsa_key.private_key_pem
  filename = "agent-key.pem"
  file_permission = "0400"
}

resource "aws_instance" "ec2" {
    ami = "ami-0827b3068f1548bf6"
    instance_type = "t2.micro"
    key_name = aws_key_pair.ssh_key.key_name

    tags = {
        Name = "agent"
    }  
}

output "ec2_info" {
  value = {
    public_ip = aws_instance.ec2.public_ip
    private_ip = aws_instance.ec2.private_ip
    command_to_connect = "ssh -i ${local_file.ssh_private_key.filename} ubuntu@${aws_instance.ec2.public_ip}"
  }
}
