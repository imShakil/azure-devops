provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "agent_key.pub"
  public_key = file(var.ssh_public_key_path)
}

resource "random_pet" "pet" {

}

resource "aws_instance" "ec2" {
    ami = "ami-0827b3068f1548bf6"
    instance_type = "t2.micro"
    key_name = aws_key_pair.ssh_key.key_name

    user_data_base64 = base64encode(templatefile("../scripts/install_agent.sh", {
      OrganizationURL = var.orgURL
      PAT = var.personal_access_token
      PoolName = var.agent_pool_name
      AgentName = "${var.agent_pool_name}-${random_pet.pet.id}"
    }))

    tags = {
        Name = "agent"
    }  
}

output "ec2_info" {
  value = {
    public_ip = aws_instance.ec2.public_ip
    private_ip = aws_instance.ec2.private_ip
    command_to_connect = "ssh ubuntu@${aws_instance.ec2.public_ip}"
    agent_name = "${var.agent_pool_name}-${random_pet.pet.id}"
  }
}
