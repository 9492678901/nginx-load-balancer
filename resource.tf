variable "ami_id" {
        type = string
        default = "ami-0cb0e70f44e1a4bb5"
}

resource "aws_instance" "apache_webserver_1"{
        ami= var.ami_id
        instance_type= "t2.micro"
        user_data= "${file("serverInstallAndDeploy.sh")}"
        key_name="abpk"
        tags = {
                Name = "apache_webserver_1"
        }
}
resource "aws_instance" "apache_webserver_2"{
        ami= var.ami_id
        instance_type= "t2.micro"
        user_data= "${file("serverInstallAndDeploy.sh")}"
        key_name="abpk"
        tags = {
                Name = "apache_webserver_2"
        }
}
resource "aws_instance" "nginxloadbalancer"{
        #ami= "${var.ami}"
        ami=var.ami_id
        instance_type= "t2.micro"
        key_name="abpk"
        user_data = "${data.template_file.init.rendered}"
        tags = {
                Name = "nginxloadbalancer"
        }
}
data "template_file" "init" {
  template = "${file("loadbalancer.sh.tpl")}"

  vars = {
            ip_address1 = "${aws_instance.apache_webserver_1.private_ip}"
            ip_address2 = "${aws_instance.apache_webserver_2.private_ip}"

  }
}
