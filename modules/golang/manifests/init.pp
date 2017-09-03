class golang {
  file { "$::myhome/gocode":
    ensure => 'directory',
  }
  exec { 'go-get-micro':
    environment => "GOPATH=${::myhome}/gocode",
    command => '/usr/bin/go get  -d github.com/zyedidia/micro/cmd/micro',
    creates => "${::myhome}/gocode/src/github.com/zyedidia/micro"
  }
  exec { 'install-micro':
    environment => "GOPATH=${::myhome}/gocode",
    cwd => "${::myhome}/gocode/src/github.com/zyedidia/micro",
    command => '/usr/bin/make install',
    creates => "${::myhome}gocode/bin/micro",
    require => Exec['go-get-micro']
  }
  exec { 'go-get-cpuacct':
    environment => "GOPATH=${::myhome}/gocode",
    command => '/usr/bin/go get github.com/uber-common/cpustat',
    creates => "${::myhome}/gocode/bin/cpuacct"
  }
  exec { 'go-get-dep':
    environment => "GOPATH=${::myhome}/gocode",
    command => '/usr/bin/go get github.com/golang/dep/cmd/dep',
    creates => "${::myhome}/gocode/bin/dep"
  }
  exec { 'go-get-wuzz':
    environment => "GOPATH=${::myhome}/gocode",
    command => '/usr/bin/go get github.com/asciimoo/wuzz',
    creates => "${::myhome}/gocode/bin/wuzz"
  }

}
