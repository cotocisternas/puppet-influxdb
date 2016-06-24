# == Class influxdb::repo
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::repo {

  Exec {
    path      => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    cwd       => '/',
  }

  case $::osfamily {
    'Debian': {
      include ::apt
      Class['apt::update'] -> Package[$influxdb::package_name]

      apt::source { 'influxdb':
        location    => "https://repos.influxdata.com/debian",
        release     => $::lsbdistcodename,
        repos       => 'stable',
        key         => $influxdb::repo_key_id,
        key_source  => $influxdb::repo_key_source,
        include_src => false,
      }
      if ($influxdb::package_pin == true and $influxdb::version != false) {
        apt::pin { $influxdb::package_name:
          ensure   => 'present',
          packages => $influxdb::package_name,
          version  => $influddb::version,
          priority => 1000,
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
