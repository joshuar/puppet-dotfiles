include ::bash
include ::emacs
include ::git

file { "$::myhome/.tmux.conf":
  ensure    => file,
  source    => 'puppet:///modules/tmux/.tmux.conf',
  owner     => $::myuser,
  group     => $::mygroup,
  mode      => '0644',
  show_diff => true
}
