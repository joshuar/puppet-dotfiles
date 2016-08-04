class emacs {
  file { "$::myhome/.emacs":
    ensure    => file,
    source    => 'puppet:///modules/emacs/.emacs',
    owner     => $::myuser,
    group     => $::mygroup,
    mode      => '0644',
    show_diff => true
  }
}
