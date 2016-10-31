class golang {
  file { "$::myhome/gocode":
    ensure => 'directory',
  }
}
