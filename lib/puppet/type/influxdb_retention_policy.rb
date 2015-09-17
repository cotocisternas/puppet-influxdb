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

  newparam :database do
  end
  
  newparam :duration do
  end
  
  newparam :replication do
  end
  
  newparam :default do
  end
  
  newparam :config do
  end
  
end
