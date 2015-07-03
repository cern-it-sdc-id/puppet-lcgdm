define lcgdm::shift::protocol ($component = $title, $proto) {
  value { "protocol_${component}-${proto}":
    component => $component,
    type      => 'PROTOCOLS',
    value     => $proto,
  }
}
