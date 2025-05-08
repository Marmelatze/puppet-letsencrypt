# @summary List of accepted plugins
type Letsencrypt::Plugin = Enum[
  'apache',
  'standalone',
  'webroot',
  'nginx',
  'dns-azure',
  'dns-route53',
  'dns-google',
  'dns-cloudflare',
  'dns-linode'
  'dns-desec'
  'dns-rfc2136',
  'manual',
]
