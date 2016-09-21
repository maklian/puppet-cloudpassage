class cloudpassage::config {

  exec { 'initialize cloudpassage':
    command     => "/opt/cloudpassage/bin/configure --api-key=${cloudpassage::apikey} --tag=${cloudpassage::tags}",
    path        => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin',
    logoutput   => on_failure,
    refreshonly => true,
  }

}
