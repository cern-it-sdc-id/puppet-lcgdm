define lcgdm::dpm::grants ($user, $pass) {
    Class[mysql::server] -> Lcgdm::Dpm::Grants <| |>
	
    mysql_user { "${user}@${name}":
      ensure        => present,
      password_hash => mysql_password($pass),
      provider      => 'mysql',
    }
    mysql_grant { "${user}@${name}/${lcgdm::ns::params::ns_db}.*":
      ensure     => 'present',
      options    => ['GRANT'],
      privileges => ['ALL'],
      table      => "${lcgdm::ns::params::ns_db}.*",
      user       => "${user}@${name}",
      require    => [ Mysql_database["${lcgdm::ns::params::ns_db}"], Mysql_user["${user}@${name}"] ],
  }
}

