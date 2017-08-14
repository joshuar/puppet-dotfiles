class argos {
  file { "${::myhome}/.config/argos":
    ensure => directory,
    owner  => $::myuser,
    group  => $::mygroup,
    mode   => '0700'
}
  argos::script { ['bandwidth','sysstat']:
    duration => '2s'
  }
}
