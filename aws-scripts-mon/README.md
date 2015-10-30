# aws-scripts-mon-cookbook
Sets up AWS CloudWatch monitoring scripts for Linux

See the relevant [AWS docs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/mon-scripts-perl.html) to get more details on what this cookbook does. 

Essentially the cookbook sets up everything that's mentioned in the docs, along with a cron job to post the data to CloudWatch at regular intervals.

## Requirements

This cookbook is only useful in an Amazon EC2 environment and will not work outside of EC2. 

You **must** assign an IAM instance role to any instance on which you wish to use this cookbook, as the IAM role is the method by which the monitoring scripts will authenticate to the AWS APIs. That role must have access to CloudWatch and CloudWatch logs.

You **can** specify the interval at which to post metrics to CloudWatch, but by default this is set to 5 minutes.

## Usage

Simply add it to your node's run list, it doesn't matter in what order. The cookbook is fully self-contained and does not expose any resources for use via another cookbook.

## Attributes

`default[:aws_monitoring_scripts][:metrics_push_interval]`: Default: `"5"`. The interval in minutes at which to run the cron job that will push metrics data to CloudWatch.
`default[:aws_monitoring_scripts][:packages]`: Default: `["perl-DateTime", "perl-Sys-Syslog", "perl-LWP-Protocol-https", "unzip"]`. A list of packages to install on the node. Don't remove any of them, but feel free to add to the array if you have special requirements.
`default[:aws_monitoring_scripts][:download_url]`: Default: `"http://aws-cloudwatch.s3.amazonaws.com/downloads"`. The URL from which to download the AWS CloudWatch monitoring scripts. You shouldn't modify this unless you know the URL has changed.
`default[:aws_monitoring_scripts][:zipfile]`: Default: `"CloudWatchMonitoringScripts-1.2.1.zip"`. The name of the file to download from the above URL. Again, don't change that unless you know what you're doing. Version 1.2.1 is the latest as of the time of writing.
`default[:aws_monitoring_scripts][:install_prefix]`: Default: `"/opt"`. The directory under which to extract the zip file (e.g. this will result in `/opt/aws-scripts-mon`).
`default[:aws_monitoring_scripts][:user]`: Default: `"awsmon"`. The service account to use to push metrics to AWS. This uses no AWS credentials since we're using an IAM role, so the only purpose of using a service account is so we don't run this as root. 

## Authors
Joe Campbell
