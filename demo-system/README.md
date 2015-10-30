# demo-system
Sets up sshd according to standards.
Also sets up a few other things:
- Installs a few useful packages to use in the shell for manual monitoring/troubleshooting/convenience
- Sets the time zone
- Sets a host name and an SSH banner 
- Sets tags on the EC2 instance


## Requirements

Amazon Linux 2015.03

**Note**: we have to use version v2.5.0 of the [aws](https://github.com/opscode-cookbooks/aws) cookbook because of [this known issue](https://github.com/opscode-cookbooks/aws/issues/104). This is set in the Berksfile.


## Usage

Simply add `demo-system::default` to your node's run list, it doesn't matter in what order. The cookbook is fully self-contained and does not expose any resources for use via another cookbook.


## Attributes

### default.rb

`[:demo][:useful_tools]`: a list of small, useful/convenient packages that will be added to each node


### aws-tags.rb

`[:demo][:jira_project]`: the JIRA project prefix for DEMO ("DEMO")


### hostname.rb

`[:demo][:hostname]`: used to set each node's hostname, replacing the OpsWorks-assigned name. You may opt to remove the corresponding code from the `hostname.rb` recipe.
`[:demo][:shell_prompt]`: updates the system PS1 variable to display the instance's FQDN rather than just the hostname.

### openssh.rb

See the docs for the [openssh cookbook](https://github.com/opscode-cookbooks/openssh/blob/master/metadata.rb), as well as the generic [sshd_config manpage](http://unixhelp.ed.ac.uk/CGI/man-cgi?sshd_config+5). The settings I'm pushing here are robust and secure, but feel free to change anything as needed.

### timezone.rb

`[:demo][:timezone]`: the desired timezone for the node, in the traditional UNIX format (e.g. `America/New_York` or `UTC`)


## Recipes

### default.rb

Installs a group of useful packages and invokes the four other recipes.

### aws-tags.rb

Adds our standard tags to the EC2 instance, via IAM role authentication. The `stackdriver_monitor => false` tag is added unless we're running in prod.


### hostname.rb

Sets the node's hostname to a fixed value rather than the random one used by OpsWorks. If you'd rather let OpsWorks choose the hostname, you can remove the `include_recipe "demo-system::hostname"` line from the default recipe.


### openssh.rb

Mostly a wrapper recipe for the official [openssh cookbook](https://github.com/opscode-cookbooks/openssh) cookbook. Also installs a banner that you see when connecting to the node via SSH.


### timezone.rb

Sets our local time zone on the instance. If you'd rather use UTC, you can remove this recipe from the default recipe, or you can update the value of the `[:demo][:timezone]` attribute.
