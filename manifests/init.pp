include ::bash
include ::emacs
include ::git
include ::golang
include ::tmux
include ::fish

if $facts['dmi']['chassis']['type'] == "Desktop" or $facts['dmi']['chassis']['type'] == "Laptop" {
  include ::argos
  include ::redshift
}

file { "${::myhome}/.config":
  ensure => directory,
  owner  => $::myuser,
  group  => $::mygroup,
  mode   => '0750',
}

vcsrepo { "${::myhome}/git/bashpass":
  ensure   => present,
  provider => git,
  user     => $::myuser,
  source   => 'git@github.com:joshuar/bashpass.git',
}
