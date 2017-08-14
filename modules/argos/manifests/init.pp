class argos {
  file { "${::myhome}/.config/argos":
    ensure => directory,
    owner  => $::myuser,
    group  => $::mygroup,
    mode   => '0640'
}
  argos::script { ['bandwidth','sysstat']:
    duration => '2s'
  }
}
