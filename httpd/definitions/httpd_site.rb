#
# Cookbook Name:: apache2
# Definition:: apache_site
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

define :httpd_site, :enable => true do
  include_recipe 'httpd::default'
  conf_name = "#{params[:name]}.conf"

  if params[:enable]
    execute "a2ensite #{conf_name}" do
      command "/usr/sbin/a2ensite #{conf_name}"
      notifies :reload, 'service[apache2]', :delayed
      not_if do
        ::File.symlink?("#{node['apache']['dir']}/sites-enabled/#{conf_name}") ||
          ::File.symlink?("#{node['apache']['dir']}/sites-enabled/000-#{conf_name}")
      end
      only_if { ::File.exist?("#{node['apache']['dir']}/sites-available/#{conf_name}") }
    end
  else
    execute "a2dissite #{conf_name}" do
      command "/usr/sbin/a2dissite #{conf_name}"
      notifies :reload, 'service[apache2]', :delayed
      only_if do
        ::File.symlink?("#{node['apache']['dir']}/sites-enabled/#{conf_name}") ||
          ::File.symlink?("#{node['apache']['dir']}/sites-enabled/000-#{conf_name}")
      end
    end
  end
end
