name             'httpd'
maintainer       'Agiletrailblazers'
maintainer_email 'info@agiletrailblazers.com'
license          'All rights reserved'
description      'Installs/Configures an Apache web server serving as a proxy for Tomcat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'iptables'
depends 'logrotate'

supports 'amazon'
