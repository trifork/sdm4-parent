class jdk() {

    package { "openjdk-6-jdk":
        ensure => installed
    }

    file {"/pack/jdk":
        ensure => symlink,
        target => "/usr/lib/jvm/java-6-openjdk",
        require => Package["openjdk-6-jdk"]
    }

    file { "/etc/profile.d/sdm_java.sh":
        ensure => present,
        content => 'JAVA_HOME=/pack/jdk
PATH=${PATH}:${JAVA_HOME}/bin',
    }
}