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

bash::config { ['.bashrc',
                '.bash_profile',
                '.bash_logout',
                '.bash_prompt',
                '.bash_alias',
                '.inputrc']:
}

exec { 'dircolors':
  command => "/usr/bin/curl -L https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark -o ~/.dircolors",
  creates => "$::myhome/.dircolors"
}

file { "$::myhome/.tmux.conf":
  ensure    => file,
  source    => 'puppet:///modules/tmux/.tmux.conf',
  owner     => $::myuser,
  group     => $::mygroup,
  mode      => '0644',
  show_diff => true
}

file { "$::myhome/.emacs":
  ensure    => file,
  source    => 'puppet:///modules/emacs/.emacs',
  owner     => $::myuser,
  group     => $::mygroup,
  mode      => '0644',
  show_diff => true
}
