# == Class influxdb::install
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::install {

  case $::osfamily {
    'Debian': {
      $package_provider = 'dpkg'
      $package_source = $::architecture ? {
        /64/    => "http://s3.amazonaws.com/influxdb/${influxdb::package_name}_${influxdb::version}_amd64.deb",
        default => "http://s3.amazonaws.com/influxdb/${influxdb::package_name}_${influxdb::version}_i386.deb",
      }
    }
    'RedHat', 'Amazon': {
      $package_provider = 'rpm'
      $package_source = $::architecture ? {
        /64/    => "http://s3.amazonaws.com/influxdb/${influxdb::package_name}-${influxdb::version}-1.x86_64.rpm",
        default => "http://s3.amazonaws.com/influxdb/${influxdb::package_name}-${influxdb::version}-1.i686.rpm",
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  staging::file { 'influxdb-package':
    source   => $package_source,
  }

  package { $influxdb::package_name:
    ensure   => $influxdb::ensure,
    provider => $package_provider,
    source   => '/opt/staging/influxdb/influxdb-package',
    require  => Staging::File['influxdb-package'],
  }

  $exec_conditional = 'gem list influxdb | egrep -q "^influxdb "'

  if $influxdb::ruby_gem {  
    exec { 'install influxdb gem':
      path    => '/bin:/usr/bin:/usr/local/bin',
      command => 'gem install influxdb -v 0.1.8',
      unless  => $exec_conditional,
    }
  } else {
    exec { 'uninstall influxdb gem':
      path    => '/bin:/usr/bin:/usr/local/bin',
      command => 'gem uninstall influxdb',
      onlyif  => $exec_conditional,
    }
  }

  if $influxdb::sensu_gem {
    exec { 'install influxdb sensu gem':
      path    => '/bin:/opt/sensu/embedded/bin',
      command => 'gem install influxdb -v 0.1.8',
      unless  => $exec_conditional,
    }
  } else {
    exec { 'uninstall influxdb sensu gem':
      path    => '/bin:/opt/sensu/embedded/bin',
      command => 'gem uninstall influxdb',
      onlyif  => $exec_conditional,
    }
  }
}
