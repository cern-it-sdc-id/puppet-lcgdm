define lcgdm::shift::protocol ($component = $title, $proto) {
  lcgdm::shift::value { "protocol_${component}-${proto}":
    component => $component,
    type      => 'PROTOCOLS',
    value     => $proto,
  }
}
