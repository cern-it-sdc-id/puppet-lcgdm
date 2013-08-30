
define lcgdm::shift::protocol($component, $proto) {

    value { "protocol_$component-$proto": component => $component, type => "PROTOCOLS", value => $proto, }

}
