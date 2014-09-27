# == Class influxdb::params
#
# This class is meant to be called from influxdb
# It sets variables according to platform
#
class influxdb::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'influxdb'
      $service_name = 'influxdb'
    }
    'RedHat', 'Amazon': {
      $package_name = 'influxdb'
      $service_name = 'influxdb'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
