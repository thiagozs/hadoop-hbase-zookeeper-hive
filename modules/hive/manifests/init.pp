class hive {
  $hive_version = "0.10.0"
  $hive_home = "/opt/hive-${hive_version}"
  $hive_tarball = "hive-${hive_version}.tar.gz"
  $hive_tarball_checksums = "${hive_tarball}.mds"

  exec { "download_grrr3":
    command => "wget --no-check-certificate http://raw.github.com/fs111/grrrr/master/grrr -O /tmp/grrr && chmod +x /tmp/grrr",
    path => $path,
    creates => "/tmp/grrr",
  }

  exec { "download_hive":
    command => "/tmp/grrr hive/hive-${hive_version}/$hive_tarball -O /vagrant/$hive_tarball --read-timeout=5 --tries=0",
    timeout => 1800,
    path => $path,
    creates => "/vagrant/$hive_tarball",
    require => [Package["openjdk-6-jdk"], Exec["download_grrr3"]]
  }

  exec { "unpack_hive":
    command => "tar xf /vagrant/${hive_tarball} -C /opt",
    path => $path,
    creates => "${hive_home}",
    require => Exec["download_hive"]
  }

  file { "/etc/profile.d/hive-path.sh":
    content => template("hive/hive-path.sh.erb"),
    owner => root,
    group => root,
  }

  file { "${hive_home}/conf/hive-env.sh":
      source => "puppet:///modules/hive/hive-env.sh",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hive"]
  }


  exec{ "load_vars_hive":
    command =>  "echo '[[ -s \'/etc/profile.d/hive-path.sh\' ]] && . \'/etc/profile.d/hive-path.sh\' # Load Hive Vars function' >> /root/.bashrc", 
    path => $path,
  }


}
