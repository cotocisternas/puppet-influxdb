# = Class: influxdb::install
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::install inherits influxdb::params {

  case $::osfamily {
    'Debian': {
      $package_provider = 'dpkg'
      $package_source = $::architecture ? {
        /64/    => "http://s3.amazonaws.com/influxdb/influxdb_${influxdb::version}_amd64.deb",
        default => "http://s3.amazonaws.com/influxdb/influxdb_${influxdb::version}_i386.deb",
      }
    }
    'RedHat', 'Amazon': {
      $package_provider = 'rpm'
      $package_source = $::architecture ? {
        /64/    => "http://s3.amazonaws.com/influxdb/influxdb-${influxdb::version}-1.x86_64.rpm",
        default => "http://s3.amazonaws.com/influxdb/influxdb-${influxdb::version}-1.i686.rpm",
      }
    }
    default: {
      fail("\"${module_name}\" provides no repository information for OSfamily \"${::osfamily}\"")
    }
  }

  # get the package
  staging::file { 'influxdb-package':
    source   => $package_source,
  }

  # install the package
  package { 'influxdb':
    ensure   => $influxdb::ensure,
    provider => $package_provider,
    source   => '/opt/staging/influxdb/influxdb-package',
    require  => Staging::File['influxdb-package'],
  }

  $exec_conditional = 'gem list influxdb | egrep -q "^influxdb "'
  Exec {
    path => '/bin:/usr/bin:/usr/local/bin',
  }

  if $influxdb::ruby {  
    exec { 'install influxdb gem':
      command => 'gem install influxdb',
      unless  => $exec_conditional,
    }
  } else {
    exec { 'uninstall influxdb gem':
      command => 'gem uninstall influxdb',
      onlyif  => $exec_conditional,
    }
  }
}