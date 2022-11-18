provider "aws" {
  region     = "us-east-1"
  access_key = "ASIAW77UEMDV6SDOLQ6I"
  secret_key = "6uXPHK7BRbHpD698LDakIDm5whljGXgXWT500dA2"
  token      = "FwoGZXIvYXdzEEkaDNlgNIelbjbQGiBhkyK1AZmJsQD038cHvf+PZ5kCtVIW+AhT8E8g8Gf7J6ECKepbdz/wZMvfzHHRAQLCqLOdilEqlaVtJlobSmImXTx2FBZBNKpaIRRyJbjxLSHfx0JugkmBuHPjZUB4jLAwdFZ1Mc0aPhFrNMRSCR+a4mLgEL6/tqntTlbDXgCigJNej14ZOL6swvxi7bsy3jcoV8lzC9a4x112RcIEm/UKIuWjO9jWwjGlGMtNW6fA7fKF6zqqC9gpPz8o3uncmwYyLeBfisY96wUqTuDf/ATZvSn4Rb0Vxv1YIMCMetBCMTOsfxL2E3p5p9V040OGfA=="
}

resource "aws_instance" "test-vm" {

  ami                    = "ami-0b0dcb5067f052a63"
  instance_type          = "t2.micro"
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    Name = "test-vm"
  }

  provisioner "file" {
    source      = "D:/Lab/data.sh"
    destination = "/home/ec2-user/data.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sh data.sh",
      "echo helloworld remote provisioner >> hello.txt",
      "date >> date.txt",
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("D:/Lab/id_rsa")
    timeout     = "4m"
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOT11GLXRe/XnYMxuVybF3REeAPCrRgL48v/I6BiSUb5oP96CUOP/NAF/B0ADvuEa64N8HhxW+8TXCXrwx2m5LPV6sE+6D/Kb0o3r6tMHYLHfK5TPwGTo+XBVMVaXcX6MqTad/TGz6zVkL4gDTcj4FaeZd6gJeY/q6sEDNqEfyeUujKJD7aaJVnzadjkoTVv84PaaMr49D3suZFCOqH4QNAG2fbTJbCUF9XRBSw2ZpmfbqrsQXbM/r+3Q8MsUek7yidzyTu2i6O63BluZai4ex4UnWJd4O+WhNyqH2eePoMg5Q1hScsr56abjqpK/QP6XHoPXncRX5bp11vsO5jmtp rangn@rjinfo"
}
