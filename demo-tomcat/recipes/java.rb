#
# Cookbook Name:: demo-tomcat
# Recipe:: java
#
# Copyright 2015, AgileTrailblazers
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java::default"

bash "Set the desired version of Java as the default" do
  code <<-EOF
  alternatives --set java #{node[:java][:binary]}
  EOF
end
