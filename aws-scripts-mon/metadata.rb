name             'aws-scripts-mon'
maintainer       'Agiletrailblazers'
maintainer_email 'info@agiletrailblazers.com'
license          'All rights reserved'
description      'Installs/Configures AWS CloudWatch monitoring tools for Linux'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'amazon'

depends 'cron'
