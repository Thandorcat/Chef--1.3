remote_file 'HelloWorldWebApp.zip' do
  source 'http://centerkey.com/jboss/HelloWorldWebApp.zip'
  action :create
end

bash "Deploy App" do
  code <<-SHELL
  unzip HelloWorldWebApp.zip
  cp HellowWorld/helloworld.war /opt/wildfly/standalone/deployments/
  SHELL
end

service 'wildfly' do
  action [:restart]
end

bash "Wait for WildFly to boot" do
  code <<-SHELL
  sleep 30
  SHELL
end
