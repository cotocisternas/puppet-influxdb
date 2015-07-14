require File.expand_path(File.join(File.dirname(__FILE__), '..', 'influxdb'))

Puppet::Type.type(:influxdb_database).provide(:default, :parent => Puppet::Provider::InfluxDB) do
  def create
    influxdb.create_database resource["name"], database_options
  end

  def destroy
    influxdb.delete_database resource["name"]
  end

  def exists?
    influxdb.get_database_list.any? { |db| db["name"] == resource["name"] }
  end

  private

  def database_options
    {}.tap do |o|
      if resource["replication_factor"]
        o["replicationFactor"] = resource["replication_factor"].to_i
      end
    end
  end
end
