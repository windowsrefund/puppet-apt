define apt::mirror(
$ensure = 'present',
$uri = 'http://mirror.rit.edu/debian', 
$sections = [ 'squeeze', 'main', 'contrib' ],
$cron_hour = '4',
$cron_minute = '0'
) 
{

  include packages
	Package <| title == apt-mirror |>

  apt_mirror { $name: 
    ensure => $ensure, 
    uri => $uri,
    sections => $sections,
  }

  cron { apt-mirror:
    ensure => $ensure,
    command => '/usr/bin/apt-mirror > /var/spool/apt-mirror/var/cron.log',
    hour => $cron_hour,
    minute => $cron_minute
  }

  # use our nginx module here...

}
