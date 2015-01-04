geoserver_on_vagrant
====================
 
Why 
---

geoserver_on_vagrant is a learning project for taking over vagrant and puppet.
His goal is to build a VM that ships geoserver. Tomcat is the web container and NGINX is a reverse proxy that also serve the static content.

How to use it
-------------

To use it install vagrant (and if not already done virtual box)
https://www.vagrantup.com/downloads.html
Then 

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

Troubleshooting
---------------
This process download a lot of file, and network in not always reliable you may have this kind of message 

    Error: /Stage[main]//Node[geoserver]/Tomcat::Instance[tommaps]/
    Tomcat::Instance::Source[tommaps]/Staging::File[apache-tomcat-7.0.57.tar.gz]
    /Exec[/opt/staging/tomcat/apache-tomcat-7.0.57.tar.gz]/returns: change 
    from notrun to 0 failed: curl  -f -L -o /opt/staging/tomcat/
    apache-tomcat-7.0.57.tar.gz http://mirrors.ircam.fr/pub/apache/tomcat
    /tomcat-7/v7.0.57/bin/apache-tomcat-7.0.57.tar.gz returned 6 instead 
    of one of [0]

Which means curls didn't resolve mirrors.ircam.fr, in this case retry the provisionning 

    vagrant reload --provision





