Puppet::Type.newtype :influxdb_retention_policy do
  # require 'puppet/parameter/boolean'
  @doc = "Manage InfluxDB retention policy"
  ensurable do
    newvalue(:present) { provider.create }
    newvalue(:absent) { provider.destroy }
    defaultto :present
  end

  autorequire(:service) { 'influxdb' }

  newparam :name do
    isnamevar
  end

  newparam :database
  newparam :duration
  newparam :replication
  newparam :default
  newparam :config
end
