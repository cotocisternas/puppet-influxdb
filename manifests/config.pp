# == Class influxdb::config
#
# This class is called from influxdb
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::config inherits influxdb {

  file { $influxdb::base_path:
    ensure  => directory,
    owner   => $influxdb::user,
    group   => $influxdb::group,
    mode    => '0755',
  }

  file { $influxdb::config_path:
    ensure  => $influxdb::ensure,
    owner   => $influxdb::user,
    group   => $influxdb::group,
    mode    => '0644',
    content => template('influxdb/influxdb.conf.erb'),
    notify  => Service[$influxdb::service_name],
    require => File[$influxdb::base_path],
  }

  file { '/etc/default/influxdb':
    ensure  => $influxdb::ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('influxdb/influxdb_default.erb'),
    notify  => Service[$influxdb::service_name],
  }
}
