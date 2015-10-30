name             'demo-tomcat'
maintainer       'Agiletrailblazers'
maintainer_email 'info@agiletrailblazers.com'
license          'All rights reserved'
description      'Installs/Configures demo-tomcat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "default", "Orchestrates the other recipes"
recipe "java", "Installs Java 8"
recipe "tomcat", "Install Tomcat 8"

depends 'java'

supports 'amazon'
