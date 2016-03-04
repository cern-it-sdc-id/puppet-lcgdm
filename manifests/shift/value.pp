define lcgdm::shift::value ($component = $title, $type, $value) {
  include('lcgdm::shift::config')

  augeas { "shiftvalue_${component}-${type}-${value}":
    context => '/files/etc/shift.conf',
    changes => [
      "rm name[.='$component'][type='$type']",
      "set name[last()+1] $component",
      "set name[last()]/type $type",
      "set name[last()]/value[0] '$value'",
      ],
    onlyif  => "match name[.='$component'][type='$type' and value='$value'] size == 0",
    require => File['/etc/shift.conf'],
  }

}
