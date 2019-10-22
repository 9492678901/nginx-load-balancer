resource "aws_instance" "apache_webserver_1"{
	ami= "ami-00c03f7f7f2ec15c3"
	instance_type= "t2.micro"
	user_data= "${file("serverInstallAndDeploy.sh")}"
	key_name="test"
	tags = {
    		Name = "apache_webserver_1"
  	}
}
resource "aws_instance" "apache_webserver_2"{
        ami= "ami-00c03f7f7f2ec15c3"
        instance_type= "t2.micro"
	user_data= "${file("serverInstallAndDeploy.sh")}"
	key_name="test"
        tags = {
                Name = "apache_webserver_2"
        }
}
resource "aws_instance" "nginxloadbalancer"{
        #ami= "ami-0270f291a8a0f0d6b"
	ami="ami-00c03f7f7f2ec15c3"
        instance_type= "t2.micro"
	key_name="test"
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
