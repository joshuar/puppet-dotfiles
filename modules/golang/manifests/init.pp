class golang {
  file { "${::myhome}/gocode":
    ensure => 'directory',
  }

  golang::get { 'cpustat':
    package => 'github.com/uber-common/cpustat',
    binary  => 'cpustat'
  }

  golang::get { 'dep':
    package => 'github.com/golang/dep/cmd/dep',
    binary  => 'dep'
  }

  golang::get { 'govendor':
    package => 'github.com/kardianos/govendor',
    binary  => 'govendor'
  }

  golang::get { 'wuzz':
    package => 'github.com/asciimoo/wuzz',
    binary  => 'wuzz'
  }
}
