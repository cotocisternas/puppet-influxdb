require File.expand_path("../../influxdb", __FILE__)

Puppet::Type.type(:influxdb_continuous_queries).provide(:default, :parent => Puppet::Provider::InfluxDB) do
  confine :feature => :influxdb

  def create
    name            = resource[:name]
    database        = resource[:database]
    query           = resource[:query]
    options         = {:resample_every => resource[:resample_every], :resample_for => resource[:resample_for]}

    influxdb.create_continuous_query(name,database,query,options)

  end

  def destroy
    influxdb.delete_retention_policy resource[:name], resource[:database]
  end

  def exists?
    influxdb.list_continuous_queries(resource[:database]).any? { |query| query["name"] == resource[:name] }
  end
end
