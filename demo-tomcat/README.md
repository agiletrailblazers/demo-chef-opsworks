# demo-tomcat Cookbook
Sets up Java 8 using the Java cookbook.
Sets up Tomcat 8 via package.


## Requirements
Designed to work on Amazon Linux 2015.03.
Depends on the [Java](https://github.com/agileorbit-cookbooks/java) cookbook.


## Attributes

#### java
`[:java][:home]`: the path to $JAVA_HOME, used by Tomcat's config file
`[:java][:binary]`: adds `/bin/java` to the above attribute

The other three attributes you'll see in `attributes/java.rb` are used by the Java cookbook.

#### tomcat
`[:tomcat][:version]`: String. The major version of Tomcat to install. Default: `"8"`.
`[:tomcat][:package]`: String. The Amazon Linux package for the desired version of Tomcat. Default: `"tomcat#{node[:tomcat][:version]}"`.


## Usage

#### demo-tomcat::default
Does nothing except invoke the other recipes.

#### demo-tomcat::java
Installs Oracle Java, not OpenJDK.
Also sets Oracle Java as the default `java` binary.

#### demo-tomcat::tomcat
Installs Tomcat.

You can use the recipes independently from one another, although Tomcat won't be very useful without Java.

The standard way of using the cookbook is simply to use `demo-tomcat::default` to your run list.
