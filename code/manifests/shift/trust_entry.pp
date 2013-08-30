define lcgdm::shift::trust_entry($component, $all=false, $type='TRUST') {

    if $all {
      entry { 
        "entryt_$component": component => $component, type => "TRUST";
        "entrytr_$component": component => $component, type => "RTRUST";
        "entrytw_$component": component => $component, type => "WTRUST";
        "entrytx_$component": component => $component, type => "XTRUST";
        "entrytf_$component": component => $component, type => "FTRUST";
      }
    } else {
      entry { "tentry_$component": component => $component, type => $type, }
    }

}
