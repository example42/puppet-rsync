# Class: rsync::params
#
# This class defines default parameters used by the main module class rsync
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to rsync class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class rsync::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'rsync',
  }

  $service = $::operatingsystem ? {
    /(?i)FreeBSD/ => 'rsyncd',
    default       => 'rsync',
  }

  $service_status = $::operatingsystem ? {
    default       => true,
  }

  $process = $::operatingsystem ? {
    default => 'rsync',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'rsync',
  }

  $config_dir = $::operatingsystem ? {
    /(?i)FreeBSD/ => '/usr/local/etc/rsyncd',
    default       => '/etc/rsync',
  }

  $config_file = $::operatingsystem ? {
    /(?i)FreeBSD/ => '/usr/local/etc/rsyncd.conf',
    default       => '/etc/rsyncd.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    /(?i)FreeBSD/ => 'wheel',
    default       => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/rsync',
    default                   => '/etc/sysconfig/rsync',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/rsyncd.pid',
  }

  $data_dir = $::operatingsystem ? {
    /(?i)FreeBSD/ => '/usr/local/etc/rsyncd',
    default       => '/etc/rsync',
  }

  $log_dir = $::operatingsystem ? {
    default => '',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/rsync.log',
  }

  $port = '873'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
