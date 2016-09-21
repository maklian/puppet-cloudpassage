class cloudpassage::apt {

  include ::apt

  apt::source { 'cloudpassage':
    ensure => present,
    key    => {
      source => 'https://packages.cloudpassage.com/cloudpassage.packages.key',
      id     => '29AF0E02ACF0366976105511013FE82585F4BB98',
    },
    location => 'http://packages.cloudpassage.com/debian',
    release  => 'debian',
    repos    => 'main',
    notify   => Exec['apt_update'],
  }

  Exec['apt_update'] -> Class['cloudpassage::install']
}
