class cfme::clone_repos(
  $rbenv_gem_repo = "git://github.com/jamis/rbenv-gemset.git",
  $rbenv_repo = "git://github.com/sstephenson/rbenv.git",
  $ruby_build_repo = "https://github.com/sstephenson/ruby-build.git"
) {

  include cfme

  $ruby_env_dir = "${cfme::home_dir}/.rbenv"

  file { "${cfme::cfme_dir}":
    ensure => "directory",
    before => Exec['git_cfme'],
  }

  # huge repo. '--depth 1' omits history
  exec { "git_cfme":
    command => "git clone ${cfme::cfme_src} ${cfme::cfme_dir}/cfme --depth 1",
    path => "/usr/bin/",
    creates => "${cfme::cfme_dir}/cfme",
  }

  exec { "git_rbenv":
    command => "git clone ${rbenv_repo} ${ruby_env_dir}",
    path => "/usr/bin/",
    creates => "${ruby_env_dir}",
  }

  exec { "git_ruby_build":
    command => "git clone ${ruby_build_repo} ${ruby_env_dir}/plugins/ruby-build",
    path => "/usr/bin/",
    creates => "${ruby_env_dir}/plugins/ruby-build",
    require => Exec['git_rbenv'],
  }

  exec { "git_rbenv_gem":
    command => "git clone ${rbenv_gem_repo} ${ruby_env_dir}/plugins/rbenv-gemset",
    path => "/usr/bin/",
    creates => "${ruby_env_dir}/plugins/rbenv-gemset",
    require => Exec['git_rbenv'],
  }

}
