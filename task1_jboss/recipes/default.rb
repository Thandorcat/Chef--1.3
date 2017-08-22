#
# Cookbook:: task1_jboss
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'unzip'

package 'net-tools'

remote_file 'wildfly-10.1.0.Final.zip' do
  source 'http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.zip'
  action :create
end

template '/etc/systemd/system/wildfly.service' do
  source 'wildfly.service'
end

bash "Install WildFly" do
  code <<-SHELL
  unzip wildfly-10.1.0.Final.zip -d /opt
  mv /opt/wildfly-10.1.0.Final /opt/wildfly
  SHELL
end


remote_file '/opt/wildfly/standalone/deployments/sample.war' do
  source 'https://github.com/apcera/sample-apps/raw/master/example-java-war/sample.war'
  action :create
end

service 'wildfly' do
  action [:enable, :start]
end

bash "Wait for WildFly to boot" do
  code <<-SHELL
  sleep 30
  SHELL
end
