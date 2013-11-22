# = Define:: rsync::get
#
# This define allows to retrieve a file using rsync
#
# Taken from
# https://github.com/puppetlabs/puppetlabs-rsync/blob/master/manifests/get.pp
# licensed Uner Apache 2 Licence.
#
# == Parameters
#
# [*source*]
#   Source to copy from
#
# [*path*]
#   Path to copy to, defaults to $name
#
# [*user*]
#   Username on remote system
#
# [*purge*]
#   If set to true (default false) rsync will use '--delete'
#
# [*exclude*]
#   String to be excluded
#
# [*keyfile*]
#   Path to ssh key used to connect to remote host, defaults to
#   /home/${user}/.ssh/id_rsa
#
# [*timeout*]
#   Timeout in seconds, defaults to 900
#
# == Examples
#
# rsync::get { '/foo':
#   source => "rsync://${rsyncServer}/repo/foo/",
#   require => File['/foo'],
# }
#
# See README for details.
#
# == Author
#   Puppetlabs https://github.com/puppetlabs
#   Baptiste Grenier <baptiste@bapt.name>
define rsync::get (
  $source,
  $path     = undef,
  $user     = undef,
  $purge    = undef,
  $exclude  = undef,
  $keyfile  = undef,
  $timeout  = '900',
  $execuser = 'root',
) {

  if $keyfile {
    $Mykeyfile = $keyfile
  } else {
    $Mykeyfile = "/home/${user}/.ssh/id_rsa"
  }

  if $user {
    $MyUser = "-e 'ssh -i ${Mykeyfile} -l ${user}' ${user}@"
  }

  if $purge {
    $MyPurge = '--delete'
  }

  if $exclude {
    $MyExclude = "--exclude=${exclude}"
  }

  if $path {
    $MyPath = $path
  } else {
    $MyPath = $name
  }

  $rsync_options = "-a ${MyPurge} ${MyExclude} ${MyUser}${source} ${MyPath}"

  exec { "rsync ${name}":
    command => "rsync -q ${rsync_options}",
    path    => [ '/bin', '/usr/bin' ],
    user    => $execuser,
    # perform a dry-run to determine if anything needs to be updated
    # this ensures that we only actually create a Puppet event if something needs to
    # be updated
    # TODO - it may make senes to do an actual run here (instead of a dry run)
    # and relace the command with an echo statement or something to ensure
    # that we only actually run rsync once
    onlyif  => "test `rsync --dry-run --itemize-changes ${rsync_options} | wc -l` -gt 0",
    timeout => $timeout,
  }
}
