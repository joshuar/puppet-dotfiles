class bash {
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
}
