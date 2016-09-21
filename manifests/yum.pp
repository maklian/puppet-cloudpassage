class cloudpassage::yum {

  yumrepo { 'cloudpassage':
    descr    => 'CloudPassage production',
    baseurl  => "http://packages.cloudpassage.com/redhat/\$basearch",
    gpgcheck => 1,
    gpgkey   => 'https://packages.cloudpassage.com/cloudpassage.packages.key'
  }

  Yumrepo['cloudpassage'] -> Class['cloudpassage::install']

}
