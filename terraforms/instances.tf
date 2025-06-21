resource "aws_instance" "bastion_nat" {
  ami = "ami-033a9abdf0ac3175c"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public[0].id
  associate_public_ip_address = true
  security_groups = [aws_security_group.bastion_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              yum install -y iptables-services
              echo 1 > /proc/sys/net/ipv4/ip_forward
              iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
              service iptables save
              EOF
  tags = { Name = "BastionNAT" }
}