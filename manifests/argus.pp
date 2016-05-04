class lcgdm::argus ($dpmhost = $::fqdn, $argus_url = undef) {
  if $argus_url == undef {
	fail("argus_url should be defined")
  }
  #install the dpm-argus
  package{'dpm-argus':
	ensure => present,
  }
  -> 
  file {'/etc/cron.hourly/dpm-argus':
    ensure  => 'present',
    owner   => root,
    group   => root,
    mode    => '0755',
    content => inline_template("
#!/bin/sh
# Sync DPM's internal user banning states from argus
export DPNS_HOST=<%= @dpmhost %>
dpns-arguspoll dpm_head <%= @argus_url %>  2>/dev/null
    ")
  }
   
}
