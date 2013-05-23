class cfme::ruby_env() {

  include cfme

  file { "ruby_env.sh":
    ensure => file,
    mode => 755,
    path => "${cfme::home_dir}/ruby_env.sh",
    source => "puppet:///modules/cfme/ruby_env.sh",    
  }

  exec { "setup_ruby_env":
    command => "${cfme::home_dir}/ruby_env.sh",
    logoutput => true,
    require => File['ruby_env.sh'],
  }

}
