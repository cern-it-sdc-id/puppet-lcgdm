define lcgdm::shift::unset ($component, $type) {
  include('lcgdm::shift::config')

  augeas { "shiftunset_${component}-${type}":
    context => '/files/etc/shift.conf',
    changes => "rm name[.='$component'][type='$type']",
    onlyif  => "match name[.='$component'][type='$type'] size != 0",
    require => [ File["$puppet_vardir/lib/augeas/lenses/shift.aug"],File['/etc/shift.conf']],
  }

}
