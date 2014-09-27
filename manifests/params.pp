# == Class influxdb::params
#
# This class is meant to be called from influxdb
# It sets variables according to platform
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::params {

  $ensure                               = 'installed'
  $ruby_gem                             = false
  $version                              = 'latest'
  $config_path                          = '/opt/influxdb/shared/config.toml'

  $hostname                             = $::hostname
  $bind_address                         = '0.0.0.0'

  # [logging]
  $logging_level                        = 'info'
  $logging_file                         = '/opt/influxdb/shared/influxdb.log'

  # [admin]
  $admin_port                           = '8083'
  $admin_assets                         = '/opt/influxdb/current/admin'

  # [api]
  $api_port                             = '8086'
  $api_read_timeout                     = '5s'

  # [input_plugins]

  # [raft]
  $raft_port                            = '8090'
  $raft_dir                             = '/opt/influxdb/shared/data/raft'
  $raft_election_timeout                = '1s'

  # [storage]
  $storage_dir                          = '/opt/influxdb/shared/data/db'
  $storage_write_buffer_size            = '10000'

  # [cluster]
  $cluster_seed_servers                 = '[]'
  $cluster_protobuf_port                = '8099'
  $cluster_protobuf_timeout             = '2s'
  $cluster_protobuf_heartbeat           = '200ms'
  $cluster_protobuf_min_backoff         = '1s'
  $cluster_protobuf_max_backoff         = '10s'
  $cluster_write_buffer_size            = '10000'
  $cluster_max_response_buffer_size     = '100'
  $cluster_concurrent_shard_query_limit = '10'

  # [leveldb]
  $leveldb_max_open_files               = '40'
  $leveldb_lru_cache_size               = '200m'
  $leveldb_max_open_shards              = '0'
  $leveldb_point_batch_size             = '100'
  $leveldb_point_write_size             = '5000000'

  # [sharding]

  # [wal]
  $wal_dir                              = '/opt/influxdb/shared/data/wal'
  $wal_flush_after                      = '0'
  $wal_bookmark_after                   = '0'
  $wal_index_after                      = '1000'
  $wal_requests_per_logfile             = '10000'

  case $::osfamily {
    'Debian': {
      $package_name     = 'influxdb'
      $service_name     = 'influxdb'
      $package_provider = 'dpkg'
      $package_source = $::architecture ? {
        /64/    => "http://s3.amazonaws.com/influxdb/${influxdb::package_name}_${influxdb::version}_amd64.deb",
        default => "http://s3.amazonaws.com/influxdb/${influxdb::package_name}_${influxdb::version}_i386.deb",
      }
    }
    'RedHat', 'Amazon': {
      $package_name = 'influxdb'
      $service_name = 'influxdb'
      $package_provider = 'rpm'
      $package_source = $::architecture ? {
        /64/    => "http://s3.amazonaws.com/influxdb/${influxdb::package_name}-${influxdb::version}-1.x86_64.rpm",
        default => "http://s3.amazonaws.com/influxdb/${influxdb::package_name}-${influxdb::version}-1.i686.rpm",
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
