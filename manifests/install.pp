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

  if $influxdb::ruby_gem {  
    exec { 'install influxdb gem':
      path    => '/bin:/usr/bin:/usr/local/bin',
      command => 'gem install influxdb',
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
      path    => '/opt/sensu/embedded/bin',
      command => 'gem install influxdb',
      unless  => $exec_conditional,
    }
  } else {
    exec { 'uninstall influxdb sensu gem':
      path    => '/opt/sensu/embedded/bin',
      command => 'gem uninstall influxdb',
      onlyif  => $exec_conditional,
    }
  }
}
