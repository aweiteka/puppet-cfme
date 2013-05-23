class cfme {
  if $::id == "root" {
    $home_dir = "/${::id}"
  }
  else {
    $home_dir = "/home/${::id}"
  }

  $github_token = "<github_auth_token>"
  $cfme_src = "https://${github_token}@github.com/ManageIQ/cfme.git"
  $cfme_dir = "/var/www"
  $db_passwd = "smartvm"
  $db_dir = "/var/lib/pgsql/data"
 
  class { 'cfme::pkg_install': } -> class { 'cfme::clone_repos': } -> class { 'cfme::ruby_env': } -> class { 'cfme::finish_config': }

}
