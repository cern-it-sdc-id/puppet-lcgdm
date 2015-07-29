#
# Example for default gridmap config:
#
#   class{"lcgdm::mkgridmap::install":}
#   lcgdm::mkgridmap::file {"edg-mkgridmap": }
#
# Example for custom mapfile:
#
#   class{"lcgdm::mkgridmap::install":}
#   lcgdm::mkgridmap::file {"lcgdm-mkgridmap":
#     configfile   => "/etc/lcgdm-mkgridmap.conf",
#     mapfile      => "/etc/lcgdm-mapfile",
#     localmapfile => "/etc/lcgdm-mapfile-local",
#     logfile      => "/var/log/lcgdm-mkgridmap.log",
#     groupmap     => {
#       "vomss://voms.hellasgrid.gr:8443/voms/dteam?/dteam/Role=lcgadmin" => "dteam",
#       "vomss://voms.hellasgrid.gr:8443/voms/dteam?/dteam/Role=production" => "dteam",
#       "vomss://voms.hellasgrid.gr:8443/voms/dteam?/dteam" => "dteam",
#       "vomss://emitestbed07.cnaf.infn.it:8443/voms/testers.eu-emi.eu" => "testers.eu-emi.eu",
#       "vomss://emitestbed27.cnaf.infn.it:8443/voms/testers2.eu-emi.eu" => "testers2.eu-emi.eu"
#     },
#     localmap    => {"nobody" => "nogroup"}
#   }
#
define lcgdm::mkgridmap::file (
  $configfile   = '/etc/edg-mkgridmap.config',
  $mapfile      = '/etc/grid-security/grid-mapfile',
  $localmapfile = '/etc/grid-mapfile-local',
  $logfile      = '/var/log/edg-mkgridmap.log',
  $groupmap     = undef,
  $localmap     = undef) {
  include('lcgdm::mkgridmap::install')

  Class[Lcgdm::Mkgridmap::Install] -> Lcgdm::Mkgridmap::File <| |>

  cron { "${configfile}-cron":
    command     => "(date; /usr/libexec/edg-mkgridmap/edg-mkgridmap.pl --conf=${configfile} --output=${mapfile} --safe) >> ${logfile} 2>&1",
    environment => 'PATH=/sbin:/bin:/usr/sbin:/usr/bin',
    user        => root,
    hour        => [5, 11, 17, 23],
    minute      => 55,
    require     => File[$configfile]
  }

  file {
    $configfile:
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => inline_template("
<% if @groupmap -%>
<% @groupmap.sort.each do |uri, vo| %>\ngroup <%= uri %> <%= vo %><% end %>
<% end -%>
gmf_local <%= @localmapfile %>
      ");

    $mapfile:
      ensure => present,
      owner  => root,
      group  => root,
      mode   => '0644';

    "${localmapfile}":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => inline_template("\
<% if @localmap -%>\
<% @localmap.sort.each do |key, value| %>\"<%= key %>\" <%= value %>\n<% end %>
<% end -%>")
  }

}

