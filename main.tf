provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_instance" "mainappbox" {
    ami = "ami-00080c12a70fa4caa"  # Ubuntu 16 en north VA
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.web.id}"]
    key_name = "${aws_key_pair.my-app-1.id}"
}

resource "aws_security_group" "web" {
    name = "web"
    description = "Allow HTTP and SSH connections."

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "my-app-1" {
    key_name = "my-app-1"
    public_key = "${file(var.public_key_path)}"
}

resource "local_file" "ansible_inventory" {
  content = <<-DOC
    #VAR to automate adding the IP of the spinned up mainappbox
    [webservers]
    ${aws_instance.mainappbox.public_ip}
    DOC
  filename = "./hosts"

}
