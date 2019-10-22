#!bin/bash -v
#sudo apt install nginx
#sudo yum install nginx
sudo amazon-linux-extras install nginx1.12 -y
sudo service nginx start
sudo chkconfig nginx on
sudo sh -c 'echo "" > /etc/nginx/nginx.conf'
sudo sh -c 'cat << EOF >> /etc/nginx/nginx.conf
events {}
http{
	upstream backend {
		server ${ip_address1}:80;
		server ${ip_address2}:80;
	}
	server{
		listen 80;
		location / {
			proxy_pass http://backend;
		}
	}
}
EOF'
sudo service nginx restart
