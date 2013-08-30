define lcgdm::shift::entry($component, $type) {

    augeas { "shiftentry_${component}-${type}":
      changes => [
          "set /files/etc/shift.conf/01/name $component",
          "set /files/etc/shift.conf/01/type $type",
    ],
      onlyif => "match /files/etc/shift.conf/*[name='$component' and type='$type'] size == 0",
      require => [ File["/usr/share/augeas/lenses/dist/shift.aug"], File["/etc/shift.conf"], ],
    }

}
