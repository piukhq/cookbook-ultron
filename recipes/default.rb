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

%w(cert.pem key.pem).each do |c|
  template "/etc/clickhouse-server/#{c}" do
    source "certificates/#{c}"
    owner 'clickhouse'
    group 'clickhouse'
    mode '0600'
    action :create
    notifies :restart, 'service[clickhouse-server]'
  end
end

execute 'generate_diffie_hellman' do
  command 'openssl dhparam -out /etc/clickhouse-server/dhparam.pem 4096'
  not_if { ::File.exist?('/etc/clickhouse-server/dhparam.pem') }
  notifies :restart, 'service[clickhouse-server]'
end

template '/etc/clickhouse-server/config.xml' do
  source 'config/config.xml'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[clickhouse-server]'
end
