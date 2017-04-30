define argos::script(
  $duration = "10s"
  ) {
  file { "$::myhome/.config/argos/${name}.${duration}.sh":
    ensure    => file,
    source    => "puppet:///modules/argos/${name}.sh",
    owner     => $::myuser,
    group     => $::mygroup,
    mode      => '0750',
    show_diff => true
  }
}
