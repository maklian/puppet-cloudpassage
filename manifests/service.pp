class cloudpassage::service {

  service { 'cphalod':
    ensure => running,
    enable => true,
  }

}
