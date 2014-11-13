class { 'apache':
  template => 'example42/apache/httpd.conf.erb',
}
apache::vhost { 'mysite':
  docroot  => '/path/to/docroot',
  template => 'example42/apache/vhost/mysite.com.erb',
}
