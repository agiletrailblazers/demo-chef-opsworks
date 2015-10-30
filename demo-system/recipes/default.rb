#
# Cookbook Name:: demo-system
# Recipe:: default
#
# Copyright 2015, Agiletrailblazers
#
# All rights reserved - Do Not Redistribute
#

node[:demo][:useful_tools].each do |pkg|
  package pkg
end

include_recipe "demo-system::hostname"
include_recipe "demo-system::timezone"
include_recipe "demo-system::openssh"
include_recipe "demo-system::aws-tags"
