# == Class influxdb::install
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::install {

  staging::file { 'influxdb-package':
    source   => $influxdb::package_source,
  }

  package { $influxdb::package_name:
    ensure   => $influxdb::ensure,
    provider => $influxdb::package_provider,
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
