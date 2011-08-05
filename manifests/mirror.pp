# Usage example: apt::mirror { something: }
#
# This will result in the following:
#
# deb http://mirror.rit.edu/debian squeeze main contrib
#
# If we want only i386 packages, we do this:
#
# apt::mirror { something: arch => 'i386' }
#
# This results in the following configuration:
#
# deb-i386 http://mirror.rit.edu/debian squeeze main contrib
#
define apt::mirror(
$ensure = 'present',
$uri = 'http://mirror.rit.edu/debian', 
$sections = [ 'squeeze', 'main', 'contrib' ],
) 
{

  include packages
	Package <| title == apt-mirror |>

  apt_mirror { $name: 
    ensure => $ensure, 
    uri => $uri,
    sections => $sections,
  }

#cd /path/to/binary
#dpkg-scanpackages binary /dev/null | gzip -9c > binary/Packages.gz
#dpkg-scansources source /dev/null | gzip -9c > source/Sources.gz

}
