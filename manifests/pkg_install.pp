class cfme::pkg_install() {

  include cfme

  # 'iconv-devel' not in repo. req'd?
  $dep_pkgs = [ "gcc-c++", "patch", "readline.x86_64", "readline-devel.x86_64", "zlib",  "zlib-devel.x86_64", "libyaml-devel", "libffi", "openssl-devel.x86_64", "make", "bzip2", "autoconf", "automake", "libtool", "bison", "ruby-devel", "qpid-cpp-client", "libxml2-devel.x86_64", "libxslt-devel.x86_64", "gcc-c++.x86_64", "memcached", "postgresql-server", "postgresql-devel", "net-tools", "screen", "git", "libffi-devel", "qpid-cpp-client-devel", "freetds-devel", "firewalld" ]

  $create_db_role = "create role root with login createdb password 'smartvm'"

  package { $dep_pkgs: ensure => "installed" }

  exec { "db_init": 
    creates => "${cfme::db_dir}",
    command => "/usr/bin/postgresql-setup initdb",
    logoutput => true,
    require => Package['postgresql-server'],
  }

  exec { "db_start":
    command => "/usr/bin/pg_ctl -D ${cfme::db_dir} start",
    user => "postgres",
    unless => "/usr/bin/test -e ${cfme::db_dir}/postmaster.pid",
    logoutput => true,
    require => Exec['db_init'],
  }

  service { "memcached":
    ensure => running,
    enable => true,
    require => Package['memcached'],
  }

  $firewall_srvcs = [ "iptables", "firewalld" ]

  # TODO: enable firewall
  service { $firewall_srvcs:
    ensure => false,
    enable => false,
  }

}
