include_recipe "httpd::default"
include_recipe "httpd::mod_proxy"

template "#{node[:apache][:dir]}/sites-available/demo.conf" do
  source "demo.conf.erb"
  owner "root"
  group "root"
  mode 00644
  notifies :reload, 'service[apache2]'
end

httpd_site "demo" do
  action :enable
end
