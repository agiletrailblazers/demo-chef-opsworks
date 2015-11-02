#
# Cookbook Name:: demo-system
# Recipe:: aws-tags
#
# Copyright 2015, Agiletrailblazers
#
# All rights reserved - Do Not Redistribute
#

include_recipe "aws::default"

aws_resource_tag node[:ec2][:instance_id] do
  tags({"jira-link" => node[:demo][:jira_project],
        "environment" => node[:demo][:environment]})
  action :update
end

if node[:demo][:stackdriver] == "no"

  aws_resource_tag node[:ec2][:instance_id] do
    tags({"stackdriver_monitor" => "false"})
    action :update
  end

end
