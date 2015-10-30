#
# Cookbook Name:: aws-scripts-mon
# Recipe:: default
#
# Copyright 2015, Agiletrailblazers
#
# All rights reserved - Do Not Redistribute
#

include_recipe "cron::default"

node[:aws_monitoring_scripts][:packages].each do |pkg|
  package pkg
end

download_url = node[:aws_monitoring_scripts][:download_url] 
zipfile = node[:aws_monitoring_scripts][:zipfile]
install_prefix = node[:aws_monitoring_scripts][:install_prefix]

remote_file "#{Chef::Config[:file_cache_path]}/#{zipfile}" do
  source "#{download_url}/#{zipfile}"
end

directory install_prefix do
  owner "root"
  group "root"
  mode 00755
  not_if { ::File.directory?(install_prefix) }
end

bash "extract zip file" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  unzip #{zipfile} -d #{install_prefix}
  EOF
  not_if { ::File.directory?("#{install_prefix}/aws-scripts-mon") }
end

# Create a non-privileged user to push the metrics instead of root
user node[:aws_monitoring_scripts][:user]

# Push memory and disk metrics to CloudWatch every x minutes
interval = node[:aws_monitoring_scripts][:metrics_push_interval]
cron_d "metrics push" do
  minute "*/#{interval}"
  command "#{install_prefix}/aws-scripts-mon/mon-put-instance-data.pl --mem-util --disk-space-util --disk-path=/ --from-cron"
  user node[:aws_monitoring_scripts][:user]
end
