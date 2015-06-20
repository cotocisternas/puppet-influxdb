# == Class influxdb::params
#
# This class is meant to be called from influxdb
# It sets variables according to platform
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::params {

  $ensure                               = 'installed'
  $ruby_gem                             = false
  $sensu_gem                            = false
  $version                              = 'latest'
  $config_path                          = '/etc/opt/influxdb/influxdb.conf'

  # [meta]
  $hostname                             = $::hostname
  $bind_address                         = '0.0.0.0'
  $meta_dir                             = '/opt/influxdb/meta'
  $meta_retention_autocreate            = 'true'
  $meta_election_timeout                = '1s'
  $meta_heartbeat_timeout               = '1s'
  $meta_leader_lease_timeout            = '500ms'
  $meta_commit_timeout                  = '50ms'

  # [data]
  $data_dir                             = '/opt/influxdb/shared/data/db'

  # [admin]
  $admin_enabled                        = 'true'

  # [hinted-handoff]
  $hinted_handoff_dir                   = '/opt/influxdb/hh'

  case $::osfamily {
    'Debian': {
      $package_name     = 'influxdb'
      $service_name     = 'influxdb'
      $package_provider = 'dpkg'
    }
    'RedHat', 'Amazon': {
      $package_name     = 'influxdb'
      $service_name     = 'influxdb'
      $package_provider = 'rpm'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
