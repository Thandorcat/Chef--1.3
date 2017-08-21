#
# Cookbook:: task1_jboss
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'unzip'

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
  sed -i 's;127.0.0.1;192.168.56.103;g' /opt/wildfly/standalone/configuration/standalone.xml
  SHELL
end


remote_file '/opt/wildfly/standalone/deployments/sample.war' do
  source 'https://github.com/apcera/sample-apps/raw/master/example-java-war/sample.war'
  action :create
end

service 'wildfly' do
  action [:enable, :start]
end

