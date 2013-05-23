# puppet-cfme

Puppet installer and environment setup for CFME from upstream source.

## Dependencies
 * Fedora 18
 * `yum install -y puppet`
 * Also `yum install -y ruby-rdoc` for puppet help
 * Access to the [cfme private repo](https://github.com/ManageIQ/cfme)
 * Assumes user directory is one of `/root` or `/home/<user>`.
 
## Instructions
1. Clone this repo into `/etc/puppet/modules`

        git clone <this_repo> /etc/puppet/modules/cfme

2. Edit `manifests/init.pp` with your [GitHub auth token](https://github.com/settings/applications). This is required to download the cfme private repo.
3. Run as `puppet apply -e "include cfme"`. Include `--noop` for dry run, `-l <cfme_install.log>` or `-v` for verbose output.
4. from `/var/www/cfme/vmdb` run

        rake db:create:all
        bin/rake db:migrate
        bin/rake evm:start

## Known issues/TODO:
1. If module is re-run then `db_create_role` will fail.
2. Ruby environment setup is fragile with the bash approach and a puppet anti-pattern. (See `files/ruby_env.sh`.)
3. Use community modules for postgres and rbenv tasks.
4. Need to include performing final rake tasks.
5. Support RHEL.
6. I'm new to puppet. 'nough said.

Please send me feedback at [aweiteka@redhat.com](mailto:aweiteka@redhat.com) with issues or suggestions. Pull requests encouraged!
