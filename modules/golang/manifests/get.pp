define golang::get (
  String[1] $package,
  String[1] $binary,
)
{
  include golang
  exec { "go get ${package}":
    environment => "GOPATH=${::myhome}/gocode",
    command     => "/usr/bin/go get ${package}",
    creates     => "${::myhome}/gocode/bin/${binary}"
  }
}
