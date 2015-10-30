# demo.opsworks
Chef/OpsWorks repo for DEMO cookbooks


## Available cookbooks

These should all be added to the OpsWorks run list, but it doesn't really matter in what order. 

**Note**: the very first time a node is provisioned, you should do a first successful deploy, then reboot the node, then proceed. You should never need to reboot it afterward. The reboot isn't required for the app to function, but it is required in order to apply some minor system-level changes, such as the system time zone or the updated `$HOSTNAME`.


### aws-scripts-mon
See this [AWS documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/mon-scripts-perl.html) for what this does. Essentially, it sets up some Perl scripts to add metrics to the default CloudWatch metrics -- in particular, RAM and disk space utilization, which are normally not included. Those additional metrics may be reviewed in CloudWatch under "Linux System Metrics".

### demo-system
Sets up the sshd server configuration and a few more things, check the README inside the cookbook's directory for more details.


### demo-httpd
Simply sets up Apache HTTP Server with the proxy module.


### demo-tomcat
Sets up Java 8 and Tomcat 8, check the README inside the cookbook's directory for more details.

#### Attributes

 * `node[:tomcat_manager][:password]` must be set in Custom JSON.
 * `node[:tomcat_manager]:username]` defaults to `deployuser` but can also be overridden in Custom JSON.

## Development
`.kitchen.yml` files exist in each cookbook folder. When testing these cookbooks using [Test Kitchen](http://kitchen.ci/), 
you'll need to define a couple of environment variables:

 * `AWS_KEYPAIR_NAME` - The name of the AWS keypair to install on the EC2 test instance.
 * `AWS_REGION` - The region to use for testing. Likely `us-east-1`.
 * `AWS_SSH_KEY` - The location of the SSH key on your local file system that corresponds with `AWS_KEYPAIR_NAME`. 
