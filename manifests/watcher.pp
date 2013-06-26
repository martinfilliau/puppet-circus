define circus::watcher($cmd, $args, $warmup_delay = 0, $numprocesses = 1,
                       $uid = "root", $gid = "root", $env = "", $priority = 0,
                        $stdout_class = "", $stdout_filename = "",
                        $stderr_class = "", $stderr_filename = "",
                        $stdout_file_max_bytes = "10485760", $stdout_file_backup_count = "10",
                        $stderr_file_max_bytes = "10485760", $stderr_file_backup_count = "10",
                        $send_hup = false, $working_dir = "") {
    include circus::manager

    file {
        "/etc/circus.d/$name.ini":
            ensure  => file,
            mode    => 0644,
            owner   => "root",
            group   => "root",
            content => template("circus/watcher.ini"),
            notify  => Exec["circus-initctl-reload"];
    }

    exec {
        "circus-restart-$name":
            refreshonly => true,
            command     => "/usr/bin/circusctl restart $name";
    }
}
