# # encoding: utf-8

# Inspec test for recipe task1_jboss::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root') do
    it { should exist }
  end
end

describe package('java-1.8.0-openjdk') do
  it { should be_installed }
end

describe service('wildfly') do
    it { should be_enabled }
    it { should be_running }
  end

# This is an example test, replace it with your own test.

describe port(8080) do
  it { should be_listening }
end


describe http('http://192.168.56.103:8080') do
  its('status') { should eq 200 }
end

describe http('http://192.168.56.103:8080/helloworld/hi.jsp') do
  its('status') { should eq 200 }
  its('body') { should match /Hello, World/i }
end
