define bash::config() {
  file { "$::myhome/${name}":
    ensure    => file,
    source    => "puppet:///modules/bash/${name}",
    owner     => $::myuser,
    group     => $::mygroup,
    mode      => '0644',
    show_diff => true
  }
}
