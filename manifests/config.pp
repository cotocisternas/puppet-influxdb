# == Class influxdb::config
#
# This class is called from influxdb
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::config inherits influxdb {

  file { $influxdb::config_path:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template('influxdb/influxdb.conf.erb'),
    notify  => Service[$influxdb::service_name],
    require => Package[$influxdb::package_name],
  }
}
