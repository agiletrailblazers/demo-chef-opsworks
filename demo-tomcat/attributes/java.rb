default[:java][:install_flavor] = "oracle"
default[:java][:jdk_version] = "8"
default[:java][:oracle][:accept_oracle_download_terms] = true
default[:java][:home] = "/usr/lib/jvm/java"
default[:java][:binary] = "#{node[:java][:home]}/bin/java"