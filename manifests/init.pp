# == Class: influxdb
#
# Full description of class influxdb here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class influxdb (
  $package_name = $influxdb::params::package_name,
  $service_name = $influxdb::params::service_name,
) inherits influxdb::params {

  # validate parameters here

  class { 'influxdb::install': } ->
  class { 'influxdb::config': } ~>
  class { 'influxdb::service': } ->
  Class['influxdb']
}
