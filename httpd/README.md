# httpd
Sets up an instance of Apache to support the Tomcat application server for Prospectr.


## Requirements

Amazon Linux 2015.03


## Usage

Simply add it to your node's run list, it doesn't matter in what order. The cookbook is fully self-contained.


## Attributes

This is mostly a copy-paste of the code of [version 3.0.0 of the apache2 cookbook](https://github.com/svanzoest-cookbooks/apache2/tree/17ed672b6e845af1cf6654eb4706a4ff7dfe7e59), with some changes since OpsWorks was being weird with the actual, official cookbook, so I suggest you don't use it. 