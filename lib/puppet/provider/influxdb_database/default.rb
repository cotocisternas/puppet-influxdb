require File.expand_path("../../influxdb", __FILE__)

Puppet::Type.type(:influxdb_database).provide(:default, :parent => Puppet::Provider::InfluxDB) do
  confine :feature => :influxdb
  
  def create
    influxdb.create_database resource["name"]
  end

  def destroy
    influxdb.delete_database resource["name"]
  end

  def exists?
    influxdb.list_databases.any? { |db| db["name"] == resource["name"] }
  end

end
