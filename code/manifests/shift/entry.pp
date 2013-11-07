define lcgdm::shift::entry($component, $type) {
  include('lcgdm::shift::config')

  augeas { "shiftentry_${component}-${type}":
    context => "/files/etc/shift.conf",
    changes => [
      "rm name[.='$component'][type='$type']",
      "set name[last()+1] $component",
      "set name[last()]/type $type",
    ],
      onlyif  => "match name[.='$component'][type='$type' and value='$value'] size == 0",
    require => [ File["/usr/share/augeas/lenses/dist/shift.aug"], File["/etc/shift.conf"], ],
  }

}
