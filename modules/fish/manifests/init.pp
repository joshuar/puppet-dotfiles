# Class fish is for the fish shell
class fish {
  include fish::omf
  fish::omf::package { 'bobthefish': }
  fish::omf::package { 'pisces': }
  fish::omf::package { 'spark': }
}
