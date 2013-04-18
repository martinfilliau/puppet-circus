define circus::statsd($description, $host, $port) {
    include circus::manager

    file {
        "/etc/circus.d/plugin-$name.ini":
            ensure  => file,
            mode    => 0644,
            owner   => "root",
            group   => "root",
            content => template("circus/plugin_statsd.ini"),
            notify  => Exec["circus-initctl-reload"];
    }
}
