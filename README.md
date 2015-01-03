geoserver_on_vagrant
====================

geoserver_on_vagrant is a learning project for taking over vagrant and puppet.
His goal is to build a VM that ships geoserver. Tomcat is the web container and NGINX is a reverse proxy that also serve the static content.

To use it install vagrant (and if not already done virtual box)
https://www.vagrantup.com/downloads.html

    git clone https://github.com/michaelcourcy/geoserver_on_vagrant.git
    cd geoserver_on_vagrant 
    vagrant up

Et voilà, go to 

http://192.168.33.10/geoserver/  

To reach the fresh geoserver you've just build 

Ssh the machine 

    vagrant ssh
    
Suspend the machine 
 
    vagrant suspend
 
 Destroy the machine 
 
    vagrant destroy




