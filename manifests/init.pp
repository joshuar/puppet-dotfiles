include ::bash
include ::emacs
include ::git
include ::redshift
include ::golang
include ::argos

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

vcsrepo { "${::myhome}/git/liquidprompt":
  ensure   => present,
  provider => git,
  source   => 'https://github.com/nojhan/liquidprompt.git',
}
