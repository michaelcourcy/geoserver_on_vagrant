##### augeas install ####

class { 'augeas' : 
	  version => 'latest', 
}
package { 'unzip': 
	ensure => 'present'
}
