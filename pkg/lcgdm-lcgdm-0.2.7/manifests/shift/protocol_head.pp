define lcgdm::shift::protocol_head ($component = $title, $protohead = $name, $host) {
  value { "protocol_${component}-${protohead}-${host}":
    component => $component,
    type      => $protohead,
    value     => $host,
  }
}
