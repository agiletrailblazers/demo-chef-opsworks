# Set [:demo][:environment] using custom JSON in the OpsWorks settings
# Recommended values: 'dev', 'qa', 'pt', 'prod'
default[:demo][:hostname] =  case node[:demo][:environment]
                                  when 'dev', 'qa', 'pt'
                                    "demo.#{node[:demo][:environment]}.agiletrailblazers.com"
                                  when 'prod'
                                    "demo.agiletrailblazers.com"
                                  end

default[:demo][:shell_prompt] = 'PS1="[\u@\H \W]\\\$ "'
