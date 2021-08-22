
#Ec2 creation
resource "aws_instance" "myec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name=aws_key_pair.keypair.key_name
    vpc_security_group_ids=[aws_security_group.allow_ports.id]
    user_data=<<-EOF
                 #!/bin/bash
                sudo yum install docker -y 
                sudo systemctl start docker
                sudo groupadd docker
                sudo usermod -aG docker $USER
                newgrp docker
                docker run -d --rm --name jenkins     -p 8080:8080 -p 50000:50000     lforlinux/jenkinspipeline:version1
                sudo yum install java-1.8.0-openjdk -y 
                sudo yum install python3
                EOF

    tags = {
        Name="S-Learn"
    }
}

#creating key pair
resource "aws_key_pair" "keypair" {
    key_name="terraformkey"
    public_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDR61VusN1H0JMxgqlFbNF9GVdSMFylK5j/ED7udWAEo2RrMcfrEcb8JccH3ld/pctcogGLGEXm+R47nv6eR6AJ0ZS2u5NHJFOfe1SxwZxJRP1fNsuOr2fJrbZoHxE0h4kyZZoCzpvdiFekgUY3BFnugKqv3PEkSzSpDqdE9o/eEnEtbpCoktBqru4uvsygwoV2vXDFR2WkE9h45b2ibIn2tfQQlS1mwHiaCv2Qjaqtg+fRomv23ZpUj2OiJ1j4JBNhVazU3PBSjlGk90+ycGwRFLJz91hWiTwSkghM1zvtcWKlW4juW+21zd5xnNbs/eaHGSVxGcauaWRY4NnG2X3 ec2-user@ip-172-31-89-157.ec2.internal"
}

#creating elastic IP
resource "aws_eip" "myeip"{
    vpc="true"
    instance=aws_instance.myec2.id
}

#get default vpc
resource "aws_default_vpc" "default" {
    tags={
        Name="Default vpc"
    }
}

resource "aws_security_group" "allow_ports"{
    name="allow_ports"
    description="Allow inbound traffic"
    vpc_id=aws_default_vpc.default.id
    ingress{
        description="http from vpc"
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    ingress{
        description="ssh from vpc"
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    ingress{
        description="tomcat port from vpc"
        from_port=8080
        to_port=8080
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    ingress{
        description="TLS from vpc"
        from_port=443
        to_port=443
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    egress{
        description="outbound from vpc"
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]
    }

    tags ={
        Name="myterraformSG"
    }

}