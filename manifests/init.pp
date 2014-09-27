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
  $version                              = $influxdb::params::version,
  $package_name                         = $influxdb::params::package_name,
  $service_name                         = $influxdb::params::service_name,
  $package_provider                     = $influxdb::params::package_provider,
  $package_source                       = $influxdb::params::package_source,
  $config_path                          = $influxdb::params::config_path,
  $hostname                             = $influxdb::params::hostname,
  $bind_address                         = $influxdb::params::bind_address,
  $logging_level                        = $influxdb::params::logging_level,
  $logging_file                         = $influxdb::params::logging_file,
  $admin_port                           = $influxdb::params::admin_port,
  $admin_assets                         = $influxdb::params::admin_assets,
  $api_port                             = $influxdb::params::api_port,
  $api_read_timeout                     = $influxdb::params::api_read_timeout,
  $raft_port                            = $influxdb::params::raft_port,
  $raft_dir                             = $influxdb::params::raft_dir,
  $raft_election_timeout                = $influxdb::params::raft_election_timeout,
  $storage_dir                          = $influxdb::params::storage_dir,
  $storage_write_buffer_size            = $influxdb::params::storage_write_buffer_size,
  $cluster_seed_servers                 = $influxdb::params::cluster_seed_servers,
  $cluster_protobuf_port                = $influxdb::params::cluster_protobuf_port,
  $cluster_protobuf_timeout             = $influxdb::params::cluster_protobuf_timeout,
  $cluster_protobuf_heartbeat           = $influxdb::params::cluster_protobuf_heartbeat,
  $cluster_protobuf_min_backoff         = $influxdb::params::cluster_protobuf_min_backoff,
  $cluster_protobuf_max_backoff         = $influxdb::params::cluster_protobuf_max_backoff,
  $cluster_write_buffer_size            = $influxdb::params::cluster_write_buffer_size,
  $cluster_max_response_buffer_size     = $influxdb::params::cluster_max_response_buffer_size,
  $cluster_concurrent_shard_query_limit = $influxdb::params::cluster_concurrent_shard_query_limit,
  $leveldb_max_open_files               = $influxdb::params::leveldb_max_open_files,
  $leveldb_lru_cache_size               = $influxdb::params::leveldb_lru_cache_size,
  $leveldb_max_open_shards              = $influxdb::params::leveldb_max_open_shards,
  $leveldb_point_batch_size             = $influxdb::params::leveldb_point_batch_size,
  $leveldb_write_batch_size             = $influxdb::params::leveldb_write_batch_size,
  $wal_dir                              = $influxdb::params::wal_dir,
  $wal_flush_after                      = $influxdb::params::wal_flush_after,
  $wal_bookmark_after                   = $influxdb::params::wal_bookmark_after,
  $wal_index_after                      = $influxdb::params::wal_index_after,
  $wal_requests_per_logfile             = $influxdb::params::wal_requests_per_logfile,
) inherits influxdb::params {

  # validate parameters here

  class { 'influxdb::install': } ->
  class { 'influxdb::config': } ~>
  class { 'influxdb::service': } ->
  Class['influxdb']
}
