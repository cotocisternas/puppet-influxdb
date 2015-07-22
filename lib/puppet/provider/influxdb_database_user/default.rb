require File.expand_path(File.join(File.dirname(__FILE__), '..', 'influxdb'))

Puppet::Type.type(:influxdb_database_user).provide(:default, :parent => Puppet::Provider::InfluxDB) do
  confine :feature => :influxdb

  def create
    influxdb.create_database_user resource["database"],
                                  resource["username"],
                                  resource["password"]
  end

  def destroy
    influxdb.delete_database_user resource["database"], resource["username"]
  end

  def exists?
    influxdb.get_database_user_list(resource["database"]).any? do |user|
      user["name"] == resource["username"]
    end
  end
end
