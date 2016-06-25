require File.expand_path("../../influxdb", __FILE__)

Puppet::Type.type(:influxdb_database_user).provide(:default, :parent => Puppet::Provider::InfluxDB) do
  confine :feature => :influxdb

  def create
    influxdb.create_database_user resource[:database],
                                  resource[:username],
                                  resource[:password]
  end

  def destroy
    influxdb.delete_database_user resource[:database], resource[:username]
  end

  def exists?
    influxdb.list_users.any? do |user|
      user["username"] == resource[:username]
    end
  end
end
