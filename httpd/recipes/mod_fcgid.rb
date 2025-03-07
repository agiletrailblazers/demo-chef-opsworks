#
# Cookbook Name:: apache2
# Recipe:: mod_fcgid
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

if platform_family?('debian')
  package 'libapache2-mod-fcgid'
elsif platform_family?('rhel', 'fedora')
  package 'mod_fcgid' do
    notifies :run, 'execute[generate-module-list]', :immediately
  end

  file "#{node['apache']['dir']}/conf.d/fcgid.conf" do
    action :delete
    backup false
  end

  directory '/var/run/httpd/mod_fcgid' do
    owner node['apache']['user']
    group node['apache']['group']
    recursive true
    only_if { node['platform_version'].to_i >= 6 }
  end
elsif platform_family?('suse')
  apache_lib_path = node['apache']['lib_dir']

  package 'httpd-devel'

  bash 'install-fcgid' do
    code <<-EOH
(cd #{Chef::Config['file_cache_path']}; wget http://superb-east.dl.sourceforge.net/sourceforge/mod-fcgid/mod_fcgid.2.2.tgz)
(cd #{Chef::Config['file_cache_path']}; tar zxvf mod_fcgid.2.2.tgz)
(cd #{Chef::Config['file_cache_path']}; perl -pi -e 's!/usr/local/apache2!#{apache_lib_path}!g' ./mod_fcgid.2.2/Makefile)
(cd #{Chef::Config['file_cache_path']}/mod_fcgid.2.2; make install)
EOH
  end
end

httpd_module 'fcgid' do
  conf true
end
