define lcgdm::shift::trust_value($component, $host, $all=false, $type='TRUST') {

    if $all {
      value { 
        "valuet_$component-$host": component => upcase($component), type => "TRUST", value => $host;
        "valuetr_$component-$host": component => upcase($component), type => "RTRUST", value => $host;
        "valuetw_$component-$host": component => upcase($component), type => "WTRUST", value => $host;
        "valuetx_$component-$host": component => upcase($component), type => "XTRUST", value => $host;
        "valuetf_$component-$host": component => upcase($component), type => "FTRUST", value => $host;
      }
    } else {
      value { "trust_$component-$host-$type": component => upcase($component), type => upcase($type), value => $host, }
    }

}
