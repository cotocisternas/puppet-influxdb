# == Class influxdb::install
#
# Author: Coto Cisternas <cotocisternas@gmail.com>
class influxdb::install {

  if $influxdb::ensure == 'present' {
    $_ensure = $influxdb::package_ensure
    $_exec_conditional = 'gem list influxdb | egrep -q "^influxdb "'

    if $influxdb::ruby_gem {
      exec { 'install influxdb gem':
        path    => '/opt/puppetlabs/puppet/bin:/bin:/usr/bin:/usr/local/bin',
        command => "gem install influxdb -v ${influxdb::gem_version}",
        unless  => $_exec_conditional,
      }
    }
  } else {
    $_ensure = 'purged'
    $_exec_conditional = 'gem list influxdb | egrep -q "^influxdb "'

    if $influxdb::ruby_gem {
      exec { 'install influxdb gem':
        path    => '/opt/puppetlabs/puppet/bin:/bin:/usr/bin:/usr/local/bin',
        command => "gem uninstall influxdb -v ${influxdb::gem_version}",
        onlyif  => $_exec_conditional,
      }
    }
  }

  package { $influxdb::package_name:
    ensure   => $_ensure,
  }

}
