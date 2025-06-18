data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

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
