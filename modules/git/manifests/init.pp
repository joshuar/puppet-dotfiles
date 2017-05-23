class git {
  file { "$::myhome/.gitconfig":
    ensure    => file,
    content   => epp('git/gitconfig.epp'),
    owner     => $::myuser,
    group     => $::mygroup,
    mode      => '0640',
    show_diff => true
  }
  file { "$::myhome/git":
    ensure => directory,
    owner  => $::myuser,
    group  => $::mygroup,
    mode   => '0640',
  }
}
