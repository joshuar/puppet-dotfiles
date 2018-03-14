class fish::omf::install {
  exec { 'retrieve_omf_installer':
    command => '/usr/bin/curl -L https://get.oh-my.fish > /tmp/omf_installer',
    creates => '/tmp/omf_installer'
  }

  exec { 'run_omf_installer':
    command => '/usr/bin/fish /tmp/omf_installer --noninteractive',
    creates => "${::myhome}/.config/omf",
    require => Exec['retrieve_omf_installer']
  }
}
