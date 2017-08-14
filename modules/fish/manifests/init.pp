# Class fish is for the fish shell
class fish {
  file { "${::myhome}/.config/fish":
    ensure => directory,
    owner  => $::myuser,
    group  => $::mygroup,
    mode   => '0640'
  }
  file { "${::myhome}/.config/fish/config.fish":
    ensure    => file,
    source    => 'puppet:///modules/fish/config.fish',
    owner     => $::myuser,
    group     => $::mygroup,
    mode      => '0640',
    show_diff => true
  }
}
