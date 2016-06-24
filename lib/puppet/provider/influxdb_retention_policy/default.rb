require File.expand_path("../../influxdb", __FILE__)

Puppet::Type.type(:influxdb_retention_policy).provide(:default, :parent => Puppet::Provider::InfluxDB) do
  confine :feature => :influxdb

  def create
    influxdb.create_retention_policy  resource[:name],
                                      resource[:database],
                                      resource[:duration],
                                      resource[:replication],
                                      resource[:default]
  end

  def destroy
    influxdb.delete_retention_policy resource[:name], resource[:database]
  end

  def exists?
    influxdb.list_retention_policies(resource[:database]).any? { |policy| policy[:name] == resource[:name] }
  end
end
