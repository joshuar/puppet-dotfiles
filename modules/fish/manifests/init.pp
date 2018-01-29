# Class fish is for the fish shell
class fish {
  exec { 'retrieve_omf_installer':
    command => '/usr/bin/curl -L https://get.oh-my.fish > /tmp/omf_installer',
    creates => '/tmp/omf_installer'
  }

  exec { 'run_omf_installer':
    command => '/usr/bin/fish /tmp/omf_installer',
    creates => "${::myhome}/.config/omf",
    require => Exec['retrieve_omf_installer']
  }

  # exec { 'omf_install_bobthefish_theme':
  #   command => '/usr/bin/fish /tmp/fish_installer',
  #   creates => "${::myhome}/.config/omf",
  #   require => Exec['run_omf_installer']
  # }

  file { "${::myhome}/.config/omf/init.fish":
    ensure    => file,
    source    => 'puppet:///modules/fish/config.fish',
    owner     => $::myuser,
    group     => $::mygroup,
    mode      => '0640',
    show_diff => true
  }
}
