default[:aws_monitoring_scripts][:metrics_push_interval] = "5"
default[:aws_monitoring_scripts][:packages] = %w(perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https unzip)
default[:aws_monitoring_scripts][:download_url] = "http://aws-cloudwatch.s3.amazonaws.com/downloads"
default[:aws_monitoring_scripts][:zipfile] = "CloudWatchMonitoringScripts-1.2.1.zip"
default[:aws_monitoring_scripts][:install_prefix] = "/opt"
default[:aws_monitoring_scripts][:user] = "awsmon"