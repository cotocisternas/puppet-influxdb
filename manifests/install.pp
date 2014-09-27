# == Class influxdb::install
#
class influxdb::install {

  package { $influxdb::package_name:
    ensure => present,
  }
}
