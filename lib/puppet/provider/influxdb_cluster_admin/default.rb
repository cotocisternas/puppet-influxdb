require File.expand_path(File.join(File.dirname(__FILE__), '..', 'influxdb'))

Puppet::Type.type(:influxdb_cluster_admin).provide(:default, :parent => Puppet::Provider::InfluxDB) do
  confine :feature => :influxdb
  
  def create
    influxdb.create_cluster_admin resource["username"], resource["password"]
  end

  def destroy
    influxdb.delete_cluster_admin resource["username"]
  end

  def exists?
    influxdb.get_cluster_admin_list.any? do |admin|
      admin["username"] == resource["username"]
    end
  end
end
