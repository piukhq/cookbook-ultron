apt_repository 'clickhouse' do
  uri 'https://repo.clickhouse.com/deb/stable/'
  distribution 'main/'
  key 'E0C56BD4'
  action :add
end

apt_package 'clickhouse-server'
apt_package 'clickhouse-client'

service 'clickhouse-server' do
  action :nothing
end

template '/etc/clickhouse-server/config.xml' do
  source 'config.xml.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[clickhouse-server]', :immediately
end
