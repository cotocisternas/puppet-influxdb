# == Class: influxdb
#
# Full description of class influxdb here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb (
  $ensure                               = $influxdb::params::ensure,
  $ruby_gem                             = $influxdb::params::ruby_gem,
  $sensu_gem                            = $influxdb::params::sensu_gem,
  $version                              = $influxdb::params::version,
  $package_name                         = $influxdb::params::package_name,
  $service_name                         = $influxdb::params::service_name,
  $package_provider                     = $influxdb::params::package_provider,
  $config_path                          = $influxdb::params::config_path,
  $hostname                             = $influxdb::params::hostname,
  $bind_address                         = $influxdb::params::bind_address,
  $data_dir                             = $influxdb::params::data_dir,
  $admin_enabled                        = $influxdb::params::admin_enabled,
  $hinted_handoff_dir                   = $influxdb::params::hinted_handoff_dir,
) inherits influxdb::params {

  # validate parameters here

  class { 'influxdb::install': } ->
  class { 'influxdb::config': } ~>
  class { 'influxdb::service': } ->
  Class['influxdb']
}
