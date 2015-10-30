#
# Cookbook Name:: demo-system
# Recipe:: timezone
#
# Copyright 2015, Agiletrailblazers
#
# All rights reserved - Do Not Redistribute
#

template "/etc/sysconfig/clock" do
  source "clock.erb"
  owner "root"
  group "root"
  mode 00644
end

link "/etc/localtime" do
  to "/usr/share/zoneinfo/#{node[:demo][:timezone]}"
end
