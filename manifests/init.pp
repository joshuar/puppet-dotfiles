define bash::config() {
  file { "$::home/${name}":
    ensure    => file,
    source    => "puppet:///modules/bash/${name}",
    owner     => $::user,
    group     => $::group,
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
  creates => "$::home/.dircolors"
}

file { "$::home/.tmux.conf":
  ensure    => file,
  source    => 'puppet:///modules/tmux/.tmux.conf',
  owner     => $::user,
  group     => $::group,
  mode      => '0644',
  show_diff => true
}

file { "$::home/.emacs":
  ensure    => file,
  source    => 'puppet:///modules/emacs/.emacs',
  owner     => $::user,
  group     => $::group,
  mode      => '0644',
  show_diff => true
}
