#
# Cookbook Name:: demo-system
# Recipe:: openssh
#
# Copyright 2015, Agiletrailblazers
#
# All rights reserved - Do Not Redistribute
#

include_recipe "openssh::default"

template node[:openssh][:server][:banner] do
  source "banner.erb"
  owner "root"
  group "root"
  mode 00644
  notifies :restart, 'service[ssh]'
end
