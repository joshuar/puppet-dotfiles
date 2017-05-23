include ::bash
include ::emacs
include ::git
include ::redshift
include ::golang
include ::argos

file { "${::myhome}/.tmux.conf":
  ensure    => file,
  source    => 'puppet:///modules/tmux/.tmux.conf',
  owner     => $::myuser,
  group     => $::mygroup,
  mode      => '0644',
  show_diff => true
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
