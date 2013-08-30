define lcgdm::shift::value($component, $type, $value) {

    augeas { "shiftvalue_$component-$type-$value":
      changes => [
          "set /files/etc/shift.conf/*[name='$component' and type='$type']/value[0] $value",
      ],
      onlyif  => "match /files/etc/shift.conf/*[name='$component' and type='$type' and value='$value'] size == 0",
      require => [ File["/usr/share/augeas/lenses/dist/shift.aug"], File["/etc/shift.conf"], ]
    }

}
