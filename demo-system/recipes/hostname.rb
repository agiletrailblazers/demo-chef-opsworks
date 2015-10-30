#
# Cookbook Name:: demo-system
# Recipe:: hostname
#
# Copyright 2015, Agiletrailblazers
#
# All rights reserved - Do Not Redistribute
#

bash "Set the hostname" do
  code <<-EOF
  sed -ie '/HOSTNAME=/ s/=.*/=#{node[:demo][:hostname]}/' /etc/sysconfig/network
  EOF
end

# Overwrite the default PS1 variable to display the full hostname
template "/etc/profile.d/overwrite_ps1.sh" do
  source "ps1.erb"
  owner "root"
  group "root"
  mode 00644
end
