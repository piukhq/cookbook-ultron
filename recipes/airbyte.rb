apt_repository 'docker' do
  arch 'amd64'
  uri 'https://download.docker.com/linux/ubuntu'
  distribution 'focal'
  components ['stable']
  key 'https://download.docker.com/linux/ubuntu/gpg'
end

package 'docker-ce'
package 'docker-ce-cli'
package 'containerd.io'

remote_file '/usr/local/bin/docker-compose' do
  source 'https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

git '/opt/airbyte' do
  repository 'https://github.com/airbytehq/airbyte.git'
  action :sync
end
