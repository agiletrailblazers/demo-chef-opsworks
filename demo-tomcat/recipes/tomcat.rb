#
# Cookbook Name:: demo-tomcat
# Recipe:: tomcat
#
# Copyright 2015, Agiletrailblazers
#
# All rights reserved - Do Not Redistribute
#

package node[:tomcat][:package]
package node[:tomcat_manager][:package]

template "/etc/tomcat8/tomcat8.conf" do
  source "tomcat8.conf.erb"
  owner "tomcat"
  group "tomcat"
  mode 00664
  notifies :restart, "service[tomcat8]"
end

template "etc/tomcat8/tomcat-users.xml" do
  source "tomcat-users.xml.erb"
  owner "tomcat"
  group "tomcat"
  mode 00664
  notifies :restart, "service[tomcat8]"
end

service "tomcat8" do
  action [ :enable, :start ]
end
