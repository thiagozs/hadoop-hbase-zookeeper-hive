class hbase {
  $hbase_version = "0.94.11"
  $hbase_home = "/opt/hbase-${hbase_version}"
  $hbase_tarball = "hbase-${hbase_version}.tar.gz"
  $hbase_tarball_checksums = "${hbase_tarball}.mds"

  file { ["/srv/hbase/",  "/srv/hbase/data"]:
    ensure => "directory"
  }

  exec { "download_grrr2":
    command => "wget --no-check-certificate http://raw.github.com/fs111/grrrr/master/grrr -O /tmp/grrr && chmod +x /tmp/grrr",
    path => $path,
    creates => "/tmp/grrr",
  }

  exec { "download_hbase":
    command => "/tmp/grrr hbase/hbase-${hbase_version}/$hbase_tarball -O /vagrant/$hbase_tarball --read-timeout=5 --tries=0",
    timeout => 1800,
    path => $path,
    creates => "/vagrant/$hbase_tarball",
    require => [Package["openjdk-6-jdk"], Exec["download_grrr2"]]
  }

  exec { "unpack_hbase":
    command => "tar xf /vagrant/${hbase_tarball} -C /opt",
    path => $path,
    creates => "${hbase_home}",
    require => Exec["download_hbase"]
  }

  file { "${hbase_home}/conf/hbase-env.sh":
      source => "puppet:///modules/hbase/hbase-env.sh",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hbase"]
  }

  file { "${hbase_home}/conf/hbase-site.xml":
      source => "puppet:///modules/hbase/hbase-site.xml",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hbase"]
  }

  file { "${hbase_home}/conf/regionservers":
      source => "puppet:///modules/hbase/regionservers",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hbase"]
  }

  # file { "/etc/profile.d/hadoop-path.sh":
  #   content => template("hadoop/hadoop-path.sh.erb"),
  #   owner => root,
  #   group => root,
  # }

}
