class fish::omf {
  contain fish::omf::install
  contain fish::omf::config
  Class['::fish::omf::install'] ->
  Class['::fish::omf::config']
}
