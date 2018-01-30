define fish::omf::package (
  String[1] $package = $name
) {
    include fish::omf
    exec { "omf install ${package}":
    command => "/usr/bin/fish -c 'omf install ${package}'",
    unless  => "/usr/bin/fish -c 'omf list' | /usr/bin/grep -q ${package}",
  }
}
