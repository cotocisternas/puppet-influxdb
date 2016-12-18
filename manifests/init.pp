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
  $ensure                                     = $influxdb::params::ensure,
  $ruby_gem                                   = $influxdb::params::ruby_gem,
  $gem_version                                = $influxdb::params::gem_version,
  $version                                    = false,
  $autoupgrade                                = $influxdb::params::autoupgrade,
  $package_name                               = $influxdb::params::package_name,
  $package_pin                                = $influxdb::params::package_pin,
  $manage_repo                                = true,
  $service_name                               = $influxdb::params::service_name,
  $repo_key_id                                = $influxdb::params::repo_key_id,
  $repo_key_source                            = $influxdb::params::repo_key_source,
  $base_path                                  = $influxdb::params::base_path,
  $config_path                                = $influxdb::params::config_path,
  $user                                       = $influxdb::params::user,
  $group                                      = $influxdb::params::group,

  $influxdb_stderr_log                        = $influxdb::params::influxdb_stderr_log,
  $influxdb_stdout_log                        = $influxdb::params::influxdb_stdout_log,
  $influxd_opts                               = $influxdb::params::influxd_opts,

  $reporting_disabled                         = $influxdb::params::reporting_disabled,
  $hostname                                   = $influxdb::params::hostname,

  $meta_dir                                   = $influxdb::params::meta_dir,
  $retention_autocreate                       = $influxdb::params::retention_autocreate,
  $logging_enabled                            = $influxdb::params::logging_enabled,
  $pprof_enabled                              = $influxdb::params::pprof_enabled,
  $lease_duration                             = $influxdb::params::lease_duration,

  $data_dir                                   = $influxdb::params::data_dir,
  $data_wal_dir                               = $influxdb::params::data_wal_dir,
  $data_engine                                = $influxdb::params::data_engine,
  $data_cache_max_memory_size                 = $influxdb::params::data_cache_max_memory_size,
  $data_cache_snapshot_memory_size            = $influxdb::params::data_cache_snapshot_memory_size,
  $data_cache_snapshot_write_cold_duration    = $influxdb::params::data_cache_snapshot_write_cold_duration,
  $data_compact_full_write_cold_duration      = $influxdb::params::data_compact_full_write_cold_duration,
  $data_max_points_per_block                  = $influxdb::params::data_max_points_per_block,
  $data_logging_enabled                       = $influxdb::params::data_logging_enabled,
  $data_query_log_enabled                     = $influxdb::params::data_query_log_enabled,
  $data_wal_logging_enabled                   = $influxdb::params::data_wal_logging_enabled,

  $retention                                  = $influxdb::params::retention,
  $retention_check_interval                   = $influxdb::params::retention_check_interval,

  $shard_precreation                          = $influxdb::params::shard_precreation,
  $shard_check_interval                       = $influxdb::params::shard_check_interval,
  $shard_advance_period                       = $influxdb::params::shard_advance_period,

  $admin_enabled                              = $influxdb::params::admin_enabled,
  $admin_bind_address                         = $influxdb::params::admin_bind_address,
  $admin_https_enabled                        = $influxdb::params::admin_https_enabled,
  $admin_https_certificate                    = $influxdb::params::admin_https_certificate,
  $admin_version                              = $influxdb::params::admin_version,

  $monitor_enabled                            = $influxdb::params::monitor_enabled,
  $monitor_database                           = $influxdb::params::monitor_database,
  $monitor_interval                           = $influxdb::params::monitor_interval,

  $subscriber_enabled                         = $influxdb::params::subscriber_enabled,

  $http_enabled                               = $influxdb::params::http_enabled,
  $http_bind_address                          = $influxdb::params::http_bind_address,
  $http_auth_enabled                          = $influxdb::params::http_auth_enabled,
  $http_log_enabled                           = $influxdb::params::http_log_enabled,
  $http_write_tracing                         = $influxdb::params::http_write_tracing,
  $http_pprof_enabled                         = $influxdb::params::http_pprof_enabled,
  $http_https_enabled                         = $influxdb::params::http_https_enabled,
  $http_https_certificate                     = $influxdb::params::http_https_certificate,
  $http_max_row_limit                         = $influxdb::params::http_max_row_limit,

  $graphite_options                           = $influxdb::params::graphite_options,
  $collectd_options                           = $influxdb::params::collectd_options,
  $opentsdb_options                           = $influxdb::params::opentsdb_options,
  $udp_options                                = $influxdb::params::udp_options,

  $continuous_queries_enabled                 = $influxdb::params::continuous_queries_enabled,
  $continuous_queries_log_enabled             = $influxdb::params::continuous_queries_log_enabled,
  $continuous_queries_run_interval            = $influxdb::params::continuous_queries_run_interval
) inherits influxdb::params {

  anchor {'influxdb::begin': }

  # validate parameters here
  if ! ($ensure in [ 'present', 'absent', 'purged' ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  }
  validate_bool($autoupgrade)
  validate_bool($manage_repo)

  if $influxdb::version == false {
    $package_ensure = $influxdb::autoupgrade ? {
      true  => 'latest',
      false => 'present',
    }
  } else {
    $package_ensure = $influxdb::version
  }

  class { 'influxdb::install': }
  class { 'influxdb::config': }
  class { 'influxdb::service': }

  if ($manage_repo == true) {
    class { 'influxdb::repo': }
    Anchor['influxdb::begin']
    -> Class['influxdb::repo']
    -> Class['influxdb::install']
  }

  if $ensure == 'present' {
    Anchor['influxdb::begin']
    -> Class['influxdb::install']
    -> Class['influxdb::config']
    -> Class['influxdb::service']
  } else {
    Anchor['influxdb::begin']
    -> Class['influxdb::install']
  }

}
