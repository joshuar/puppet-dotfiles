class fish::omf::config {
  file { "${::myhome}/.config/omf/init.fish":
    ensure    => file,
    source    => 'puppet:///modules/fish/config.fish',
    owner     => $::myuser,
    group     => $::mygroup,
    mode      => '0640',
    show_diff => true
  }
}
