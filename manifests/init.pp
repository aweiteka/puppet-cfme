# Install CFME from upstream repo and config environment
#
# Author: Aaron Weitekamp
#
# Instructions:
#  update $github_token (Github API access token)
#  Generate and copy token here: https://github.com/settings/applications
#
#  run as 'puppet apply -v -e "include cfme"'
#  append '--noop' for dry run
#
class cfme {
  if $::id == "root" {
    $home_dir = "/${::id}"
  }
  else {
    $home_dir = "/home/${::id}"
  }

  $github_token = "d854bf8cd714f6f1259f8f18af5d98845e522abb"
  $cfme_src = "https://${github_token}@github.com/ManageIQ/cfme.git"
  $cfme_dir = "/var/www"
  $db_passwd = "smartvm"
  $db_dir = "/var/lib/pgsql/data"
 
  class { 'cfme::pkg_install': } -> class { 'cfme::clone_repos': } -> class { 'cfme::ruby_env': } -> class { 'cfme::finish_config': }

}
