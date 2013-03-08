# Puppet module: rsync

This is a Puppet module for rsync based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-rsync

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.

## USAGE - Basic management

* Install rsync with default settings

        class { 'rsync': }

* Install a specific version of rsync package

        class { 'rsync':
          version => '1.0.1',
        }

* Disable rsync service.

        class { 'rsync':
          disable => true
        }

* Remove rsync package

        class { 'rsync':
          absent => true
        }

* Enable auditing without without making changes on existing rsync configuration files

        class { 'rsync':
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'rsync':
          source => [ "puppet:///modules/lab42/rsync/rsync.conf-${hostname}" , "puppet:///modules/lab42/rsync/rsync.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'rsync':
          source_dir       => 'puppet:///modules/lab42/rsync/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'rsync':
          template => 'example42/rsync/rsync.conf.erb',
        }

* Automatically include a custom subclass

        class { 'rsync':
          my_class => 'rsync::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'rsync':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'rsync':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'rsync':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'rsync':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


[![Build Status](https://travis-ci.org/example42/puppet-rsync.png?branch=master)](https://travis-ci.org/example42/puppet-rsync)
