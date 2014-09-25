# = Class: influxdb::service
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::service {
  service { 'influxdb':
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    require     => Package['influxdb'],

  }
}