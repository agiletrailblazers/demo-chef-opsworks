#
# Cookbook Name:: apache2
# Attributes:: default
#
# Copyright 2008-2013, Opscode, Inc.
# Copyright 2014, Viverae, Inc.
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

default['apache']['mpm'] = 'prefork'

default['apache']['version'] = '2.4'

default['apache']['root_group'] = 'root'
default['apache']['default_site_name'] = 'default'

# Where the various parts of apache are
default['apache']['package']     = 'httpd'
default['apache']['perl_pkg']    = 'perl'
default['apache']['apachectl']   = '/usr/sbin/apachectl'
default['apache']['dir']         = '/etc/httpd'
default['apache']['log_dir']     = '/var/log/httpd'
default['apache']['error_log']   = 'error.log'
default['apache']['access_log']  = 'access.log'
default['apache']['user']        = 'apache'
default['apache']['group']       = 'apache'
default['apache']['binary']      = '/usr/sbin/httpd'
default['apache']['conf_dir']    = '/etc/httpd/conf'
default['apache']['docroot_dir'] = '/var/www/html'
default['apache']['cgibin_dir']  = '/var/www/cgi-bin'
default['apache']['icondir']     = '/var/www/icons'
default['apache']['cache_dir']   = '/var/cache/httpd'
default['apache']['run_dir']     = '/var/run/httpd'
default['apache']['lock_dir']    = '/var/run/httpd'
default['apache']['pid_file']    = if node['platform_version'].to_f >= 6
                                     '/var/run/httpd/httpd.pid'
                                   else
                                     '/var/run/httpd.pid'
                                   end
default['apache']['lib_dir']     = node['kernel']['machine'] =~ /^i[36]86$/ ? '/usr/lib/httpd' : '/usr/lib64/httpd'
default['apache']['libexec_dir']  = "#{node['apache']['lib_dir']}/modules"


###
# These settings need the unless, since we want them to be tunable,
# and we don't want to override the tunings.
###

# General settings
default['apache']['listen_addresses']  = %w(*)
default['apache']['listen_ports']      = %w(80)
default['apache']['contact']           = 'ops@example.com'
default['apache']['timeout']           = 300
default['apache']['keepalive']         = 'On'
default['apache']['keepaliverequests'] = 100
default['apache']['keepalivetimeout']  = 5
default['apache']['locale'] = 'C'
default['apache']['sysconfig_additional_params'] = {}
default['apache']['default_site_enabled'] = false

# Security
default['apache']['servertokens']    = 'Prod'
default['apache']['serversignature'] = 'On'
default['apache']['traceenable']     = 'Off'

# mod_auth_openids
default['apache']['allowed_openids'] = []

# mod_status Allow list, space seprated list of allowed entries.
default['apache']['status_allow_list'] = '127.0.0.1 ::1'

# mod_status ExtendedStatus, set to 'true' to enable
default['apache']['ext_status'] = false

# mod_info Allow list, space seprated list of allowed entries.
default['apache']['info_allow_list'] = '127.0.0.1 ::1'

# Prefork Attributes
default['apache']['prefork']['startservers']        = 16
default['apache']['prefork']['minspareservers']     = 16
default['apache']['prefork']['maxspareservers']     = 32
default['apache']['prefork']['serverlimit']         = 256
default['apache']['prefork']['maxrequestworkers']   = 256
default['apache']['prefork']['maxconnectionsperchild'] = 10_000

# Worker Attributes
default['apache']['worker']['startservers']        = 4
default['apache']['worker']['serverlimit']         = 16
default['apache']['worker']['minsparethreads']     = 64
default['apache']['worker']['maxsparethreads']     = 192
default['apache']['worker']['threadlimit']         = 192
default['apache']['worker']['threadsperchild']     = 64
default['apache']['worker']['maxrequestworkers']   = 1024
default['apache']['worker']['maxconnectionsperchild'] = 0

# Event Attributes
default['apache']['event']['startservers']        = 4
default['apache']['event']['serverlimit']         = 16
default['apache']['event']['minsparethreads']     = 64
default['apache']['event']['maxsparethreads']     = 192
default['apache']['event']['threadlimit']         = 192
default['apache']['event']['threadsperchild']     = 64
default['apache']['event']['maxrequestworkers']   = 1024
default['apache']['event']['maxconnectionsperchild'] = 0

# mod_proxy settings
default['apache']['proxy']['require']    = 'all denied'
default['apache']['proxy']['order']      = 'deny,allow'
default['apache']['proxy']['deny_from']  = 'all'
default['apache']['proxy']['allow_from'] = 'none'

# Default modules to enable via include_recipe
default['apache']['default_modules'] = %w(
  status alias auth_basic authn_core authn_file authz_core authz_groupfile
  authz_host authz_user autoindex dir env mime negotiation setenvif
)

%w(log_config logio).each do |log_mod|
  default['apache']['default_modules'] << log_mod if %w(rhel fedora suse arch freebsd).include?(node['platform_family'])
end

if node['apache']['version'] == '2.4'
  %w(unixd).each do |unix_mod|
    default['apache']['default_modules'] << unix_mod if %w(rhel fedora suse arch freebsd).include?(node['platform_family'])
  end

#  default['apache']['default_modules'] << 'systemd' if %w(rhel fedora).include?(node['platform_family'])
end