class git {
  file { "$::myhome/.gitconfig":
    ensure    => file,
    content   => epp('git/gitconfig.epp'),
    owner     => $::myuser,
    group     => $::mygroup,
    mode      => '0644',
    show_diff => true
  }
}
