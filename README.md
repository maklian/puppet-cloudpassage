# puppet-cloudpassage module


#### Table of Contents

1. [Overview](#overview)
1. [Usage](#usage)
1. [Reference](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
    * [Module dependencies](#module-dependencies)
1. [Development](#development)

## Overview

The cloudpassage module installs and configures the CloudPassage Halo agent.

## Usage

All interaction with the cloudpassage module can be done through the main cloudpassage class.
The `apikey` parameter must be specified for the class to function.

```
class { 'cloudpassage':
  apikey => 'myapikey',
}
```

## Reference

### Classes

#### Public classes

* cloudpassage: Main class, includes all other classes.

#### Private classes

* cloudpassage::install: Handles the packages.
* cloudpassage::config: Configures the cphalo daemon on installation.
* cloudpassage::service: Handles the cphalod service.
* cloudpassage::yum: Manages the cloudpassage yum repo where applicable.
* cloudpassage::apt: Manages the cloudpassage apt repo where applicable.

### Parameters

The following parameters are available in the `cloudpassage` class:

#### `apikey`

The CloudPassage API key. This value is required.

#### `tags`

The CloudPassage tags that this node will be configured with. Defaults to `$::operatingsystem`.

## Limitations

### Module dependencies

This modules uses `puppetlabs-apt` for the management of the NodeSource
repository. If using an operating system of the Debian-based family, you will
need to ensure that `puppetlabs-apt` version 2.x is installed.

<!---
#CPTAGS:community-unsupported automation deployment
#TBICON:images/ruby_icon.png
-->
