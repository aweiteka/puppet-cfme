class cfme::finish_config() {

  include cfme

  $create_db_role = "create role root with login createdb password '${cfme::db_passwd}'"

  exec { "db_reload":
    command => "/usr/bin/pg_ctl -D ${cfme::db_dir} reload",
    user => "postgres",
    logoutput => true,
  }

  file { "${cfme::db_dir}/postgresql.conf":
    ensure => file,
    owner => "postgres",
    group => "postgres",
    mode => 600,
    source => "puppet:///modules/cfme/postgresql.conf",
    notify => Exec['db_reload'],
  }

  file { "${cfme::db_dir}/pg_hba.conf":
    ensure => file,
    owner => "postgres",
    group => "postgres",
    mode => 600,
    source => "puppet:///modules/cfme/pg_hba.conf",
    notify => Exec['db_reload'],
  }

  exec { "db_role_create":
    # TODO: check if user created. See script in files/create_db_role.sh
    # must run as postres user but cannot sudo from tty
    command => "/usr/bin/psql -c \"${create_db_role}\"",
    user => "postgres",
    logoutput => true,
  }

  file { "${cfme::home_dir}/install_vddk":
    ensure => file,
    mode => 755,
    source => "puppet:///modules/cfme/install_vddk.sh",
  }

  notify { "complete":
    message => "Browse to http://${::ipaddress}:3000",
  }

}
