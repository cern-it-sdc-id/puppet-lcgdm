define lcgdm::shift::value($component, $type, $value) {

    augeas { "shiftvalue_$component-$type-$value":
      context => "/files/etc/shift.conf",
      changes => [
        "rm name[.='$component'][type='$type']",
        "set name[last()+1] $component",
        "set name[last()]/type $type",
        "set name[last()]/value[0] '$value'",
      ],
      require => [ File["/usr/share/augeas/lenses/dist/shift.aug"], File["/etc/shift.conf"], ]
    }

}
