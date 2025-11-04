provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "nginx-server.pub"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "ec2" {
  ami           = "ami-0827b3068f1548bf6"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Nginx Server"
  }
}

resource "local_file" "inventory" {
  content = <<EOT
[app]
${aws_instance.ec2.public_ip}

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOT

  filename        = "../ansible/inventory.ini"
  file_permission = "0755"
}

output "ec2_info" {
  value = {
    public_ip          = aws_instance.ec2.public_ip
    private_ip         = aws_instance.ec2.private_ip
    command_to_connect = "ssh ubuntu@${aws_instance.ec2.public_ip}"
  }
}
