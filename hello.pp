define apache::dotconf (
  $enable   = true,
  $source   = '' ,
  $content  = '' ,
  $priority = '',
  $ensure   = present,
) {

  $manage_file_source = $source ? {
    ''        => undef,
    default   => $source,
  }

  $manage_file_content = $content ? {
    ''        => undef,
    default   => $content,
  }

  # Config file path
  if $priority != '' {
    $dotconf_path = "${apache::dotconf_dir}/${priority}-${name}.conf"
  } else {
    $dotconf_path = "${apache::dotconf_dir}/${name}.conf"
  }

  # Config file enable path
  if $priority != '' {
    $dotconf_enable_path = "${apache::config_dir}/conf-enabled/${priority}-${name}.conf"
  } else {
    $dotconf_enable_path = "${apache::config_dir}/conf-enabled/${name}.conf"
  }

  file { "Apache_${name}.conf":
    ensure  => $ensure,
    path    => $dotconf_path,
    mode    => $apache::config_file_mode,
    owner   => $apache::config_file_owner,
    group   => $apache::config_file_group,
    require => Package['apache'],
    notify  => $apache::manage_service_autorestart,
    source  => $manage_file_source,
    content => $manage_file_content,
    audit   => $apache::manage_audit,
  }

  # Some OS specific settings:
  # Ubuntu 14 uses conf-available / conf-enabled folders
  case $::operatingsystem {
    /(?i:Ubuntu)/ : {
      case $::lsbmajdistrelease {
        /14/ : {
          $dotconf_link_ensure = $enable ? {
            true  => $dotconf_path,
            false => absent,
          }

          file { "ApacheDotconfEnabled_${name}":
            ensure  => $dotconf_link_ensure,
            path    => $dotconf_enable_path,
            require => Package['apache'],
          }
        }
        default: { }
      }
    }
    default: { }
 

end
