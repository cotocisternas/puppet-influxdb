Puppet::Type.newtype :influxdb_continuous_queries do
  @doc = "Manage InfluxDB Continuous Queries"
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

  newparam :query do
  end

  newparam :resample_every do
  end

  newparam :resample_for do
  end

  newparam :config do
  end

end
