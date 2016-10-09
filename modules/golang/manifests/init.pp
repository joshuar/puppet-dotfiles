class golang {
  package { 'golang':
    ensure => 'installed'
  }
  file { "$::myhome/gocode":
    ensure => 'directory',
  }
}
