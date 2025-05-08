# @summary Installs and configures the dns-desec plugin
#
# This class installs and configures the Let's Encrypt dns-desec plugin.
# https://certbot-dns-desec.readthedocs.io
#
# @param package_name The name of the package to install when $manage_package is true.
# @param token
#   Optional string, desec api key value for authentication.
# @param config_path The path to the configuration directory.
# @param manage_package Manage the plugin package.
# @param propagation_seconds Number of seconds to wait for the DNS server to propagate the DNS-01 challenge.
#
class letsencrypt::plugin::dns_desec (
  String[1] $token,
  Optional[String[1]] $package_name = undef,
  String[1] $version                = '4',
  Stdlib::Absolutepath $config_path = "${letsencrypt::config_dir}/dns-desec.ini",
  Boolean $manage_package           = true,
  Integer $propagation_seconds      = 120,
) {
  include letsencrypt

  if $manage_package {
    if ! $package_name {
      fail('No package name provided for certbot dns desec plugin.')
    }

    $requirement = if $letsencrypt::configure_epel {
      Class['epel']
    } else {
      undef
    }

    package { $package_name:
      ensure  => $letsencrypt::package_ensure,
      require => $requirement,
    }
  }

  $ini_vars = {
    dns_desec_token => $token,
  }

  file { $config_path:
    ensure  => file,
    owner   => 'root',
    group   => 0,
    mode    => '0400',
    content => epp('letsencrypt/ini.epp', {
        vars => { '' => $ini_vars },
      },
    ),
  }
}
