# == Class influxdb::params
#
# This class is meant to be called from influxdb
# It sets variables according to platform
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::params {

  $ensure                                       = 'present'
  $autoupgrade                                  = false
  $package_pin                                  = false
  $repo_key_id                                  = '05CE15085FC09D18E99EFB22684A14CF2582E0C5'
  $repo_key_source                              = 'https://repos.influxdata.com/influxdb.key'
  $ruby_gem                                     = true
  $gem_version                                  = '0.3.13'
  $config_path                                  = '/etc/influxdb/influxdb.conf'
  $base_path                                    = '/opt/influxdb'
  $user                                         = 'influxdb'
  $group                                        = 'influxdb'

  $influxdb_stderr_log                          = '/var/log/influxdb/influxd.log'
  $influxdb_stdout_log                          = '/dev/null'
  $influxd_opts                                 = undef

  $reporting_disabled                           = false
  $hostname                                     = $::hostname

  #[meta]
  $meta_dir                                     = "${base_path}/meta"
  $retention_autocreate                         = true
  $logging_enabled                              = true
  $pprof_enabled                                = false
  $lease_duration                               = "1m0s"

  #[data]
  $data_dir                                     = "${base_path}/data"
  $data_wal_dir                                 = "${base_path}/wal"
  $data_engine                                  = "tsm1"
  $data_cache_max_memory_size                   = "524288000"
  $data_cache_snapshot_memory_size              = "26214400"
  $data_cache_snapshot_write_cold_duration      = "1h0m0s"
  $data_compact_full_write_cold_duration        = "24h0m0s"
  $data_max_points_per_block                    = "0"
  $data_logging_enabled                         = "true"
  $data_query_log_enabled                       = "true"
  $data_wal_logging_enabled                     = "true"

  #[cluster] // TODO

  #[retention]
  $retention                                    = true
  $retention_check_interval                     = "30m0s"

  #[shard-precreation]
  $shard_precreation                            = true
  $shard_check_interval                         = "10m0s"
  $shard_advance_period                         = "30m0s"

  #[admin]
  $admin_enabled                                = true
  $admin_bind_address                           = ":8083"
  $admin_https_enabled                          = false
  $admin_https_certificate                      = "/etc/ssl/influxdb.pem"
  $admin_version                                = undef

  #[monitor]
  $monitor_enabled                              = true
  $monitor_database                             = "_internal"
  $monitor_interval                             = "10s"

  #[subscriber]
  $subscriber_enabled                           = true

  #[http]
  $http_enabled                                 = true
  $http_bind_address                            = ":8086"
  $http_auth_enabled                            = false
  $http_log_enabled                             = true
  $http_write_tracing                           = false
  $http_pprof_enabled                           = false
  $http_https_enabled                           = false
  $http_https_certificate                       = "/etc/ssl/influxdb.pem"
  $http_max_row_limit                           = "10000"

  $graphite_options                             = undef
  $collectd_options                             = undef
  $opentsdb_options                             = undef
  $udp_options                                  = undef

  $continuous_queries_enabled                   = true
  $continuous_queries_log_enabled               = true
  $continuous_queries_run_interval              = undef

  case $::osfamily {
    'Debian': {
      $package_name     = 'influxdb'
      $service_name     = 'influxdb'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
