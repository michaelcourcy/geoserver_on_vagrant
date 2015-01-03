node 'geoserver' {

  #manage iptables
  #This will clear any existing rules and make sure that only 
  #rules defined in Puppet exist on the machine
  resources { "firewall":
    purge => true
  }
  firewall { '100 allow http and https access':
      port   => [80, 443],
      proto  => tcp,
      action => accept,
  }
         
  # base directory owned by root  
	file { "/appli" :
          ensure => "directory",		
	}
   
  #tomcat services 
  class { 'java': }
  class { 'tomcat': 
    user => 'tomapps',
    group => 'tomapps',
  }
  tomcat::instance { 'tommaps':
    source_url => 'http://mirrors.ircam.fr/pub/apache/tomcat/tomcat-7/v7.0.57/bin/apache-tomcat-7.0.57.tar.gz',
    catalina_base => '/appli/tomcat',    
  } -> 
  tomcat::config::server::connector { 'tommaps-http':
    catalina_base         => '/appli/tomcat',
    port                  => '8080',
    protocol              => 'HTTP/1.1',
    #support for the proxy
    additional_attributes => {
      'redirectPort' => '8443',
      'proxyPort' => '80',
      'proxyName' => '192.168.33.10',
    },
  } -> tomcat::war {'geoserver.war':
    catalina_base => '/appli/tomcat',
    war_source => 'http://softlayer-ams.dl.sourceforge.net/project/geoserver/GeoServer/2.5.4/geoserver-2.5.4-war.zip'
  } -> tomcat::service { 'tommaps': 
    catalina_base => '/appli/tomcat',
  }
    	
  
	#nginx services
  class {'nginx':}    
  #create an upstream with tomcat
  nginx::resource::upstream { 'tomcat':
    members => [
     '127.0.0.1:8080',    
    ],
  } 
  nginx::resource::vhost { 'geoserver.local' : 
     www_root => '/appli/tomcat/webapps',
     try_files => ['$uri $uri/ @proxy_tomcat'],     
  }
  #the proxy pass to tomcat
  nginx::resource::location { '@proxy_tomcat': 
     vhost => 'geoserver.local',
     location => '@proxy_tomcat',
     proxy => 'http://tomcat',
     proxy_set_header => 
        [
            'X-Forwarded-Host $host',
            'X-Forwarded-Server $host',
            'X-Forwarded-For $proxy_add_x_forwarded_for',
        ],
  }
  
  
} 
