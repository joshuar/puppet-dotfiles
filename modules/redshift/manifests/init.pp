class redshift {
  file { "$::myhome/.config/redshift.conf":
    ensure    => file,
    source    => 'puppet:///modules/redshift/redshift.conf',
    owner     => $::myuser,
    group     => $::mygroup,
    mode      => '0644',
    show_diff => true
  }
}
