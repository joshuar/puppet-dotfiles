class golang {
  file { "$::myhome/gocode":
    ensure => 'directory',
  }
  exec { 'go-get-micro':
    environment => "GOPATH=${::myhome}/gocode",
    command => '/usr/bin/go get -d github.com/zyedidia/micro/cmd/micro',
    creates => "${::myhome}/gocode/src/github.com/zyedidia/micro"
  }
  exec { 'install-micro':
    environment => "GOPATH=${::myhome}/gocode",
    cwd => "${::myhome}/gocode/src/github.com/zyedidia/micro",
    command => '/usr/bin/make install',
    creates => "${::myhome}/gocode/bin/micro",
    require => Exec['go-get-micro']
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
