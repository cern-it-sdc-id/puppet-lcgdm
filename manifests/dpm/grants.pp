define lcgdm::dpm::grants ($user, $pass) {
    mysql_user { "${user}@${name}":
      ensure        => present,
      password_hash => mysql_password($pass),
      provider      => 'mysql',
    }
    mysql_grant { "${user}@${name}/cns_db.*":
      ensure     => 'present',
      options    => ['GRANT'],
      privileges => ['ALL'],
      table      => 'cns_db.*',
      user       => "${user}@${name}",
      require    => [ Mysql_database['cns_db'], Mysql_user["${user}@${name}"] ],
  }
}

