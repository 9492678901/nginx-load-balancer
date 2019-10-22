#!bin/bash -v
sudo yum -y install httpd
sudo service httpd start
sudo chkconfig httpd on
sudo touch /var/www/html/index.html
echo "<h1 style:'color:green'> hello world</h1>" > /var/www/html/index.html
sudo service httpd restart
