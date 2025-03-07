#
# Cookbook Name:: apache2
# Recipe:: apreq2
#
# modified from the python recipe by Jeremy Bingham
#
# Copyright 2008-2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'httpd::default'

case node['platform_family']
when 'debian'
  package 'libapache2-mod-apreq2'
when 'suse'
  package 'apache2-mod_apreq2' do
    notifies :run, 'execute[generate-module-list]', :immediately
  end
when 'rhel', 'fedora'
  package 'libapreq2' do
    notifies :run, 'execute[generate-module-list]', :immediately
  end

  # seems that the apreq lib is weirdly broken or something - it needs to be
  # loaded as 'apreq', but on RHEL & derivitatives the file needs a symbolic
  # link to mod_apreq.so.
  link "#{node['apache']['libexec_dir']}/mod_apreq.so" do
    to "#{node['apache']['libexec_dir']}/mod_apreq2.so"
    only_if "test -f #{node['apache']['libexec_dir']}/mod_apreq2.so"
  end
end

file "#{node['apache']['dir']}/conf.d/apreq.conf" do
  action :delete
  backup false
end

httpd_module 'apreq'
