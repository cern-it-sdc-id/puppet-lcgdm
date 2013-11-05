define lcgdm::shift::entry($component, $type) {

    augeas { "shiftentry_${component}-${type}":
      incl    => "/etc/shift.conf",
      lens    => "shift.aug",
      changes => [
        "rm name[.='$component'][type='$type']",
        "set name[last()+1] $component",
        "set name[last()]/type $type",
      ],
      onlyif  => "match name[.='$component'][type='$type'] size == 0",
      require => [ File["/usr/share/augeas/lenses/dist/shift.aug"], File["/etc/shift.conf"], ],
    }

}
