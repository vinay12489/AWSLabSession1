resource "aws_instance" "ec2" {
  ami             = "ami-0af9569868786b23a"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.SG.id]
  user_data       = <<-EOF
    #!/bin/bash
    yum install -y httpd
    systemstcl start httpd
    systemstcl enable httpd
    eco "<h1> hello vinay..welcome to javahomecloud <h2>" /var/www/html/index.html
    EOF
  tags = {
    Name = "webserver"
  }
}