# == Class influxdb::install
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::install {

  if $influxdb::ensure == 'present' {
    $_ensure = $influxdb::package_ensure

    if $influxdb::ruby_gem {
      package { 'influxdb_gem':
        name      => 'influxdb',
        ensure    => $influxdb::gem_version,
        provider  => 'puppet_gem',
      }
    }
  } else {
    $_ensure = 'purged'

    if $influxdb::ruby_gem {
      package { 'influxdb_gem':
        name      => 'influxdb',
        ensure    => 'absent',
        provider  => 'puppet_gem',
      }
    }
  }

  package { $influxdb::package_name:
    ensure   => $_ensure,
  }

}
