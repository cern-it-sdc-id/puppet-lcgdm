define lcgdm::shift::trust_entry ($component, $all = false, $type = 'TRUST') {
  if $all {
    entry {
      "entryt_$component":
        component => upcase($component),
        type      => 'TRUST';

      "entrytr_$component":
        component => upcase($component),
        type      => 'RTRUST';

      "entrytw_$component":
        component => upcase($component),
        type      => 'WTRUST';

      "entrytx_$component":
        component => upcase($component),
        type      => 'XTRUST';

      "entrytf_$component":
        component => upcase($component),
        type      => 'FTRUST';
    }
  } else {
    entry { "tentry_$component":
      component => upcase($component),
      type      => upcase($type),
    }
  }

}
