data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Official Amazon account
}

resource "aws_instance" "blog_server" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  user_data                   = file("${path.module}/userdata.sh")
  vpc_security_group_ids      = [aws_security_group.blog_server_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "MyBlogServer"
  }
}
