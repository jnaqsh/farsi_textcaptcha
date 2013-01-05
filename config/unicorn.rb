root = "/home/deployer/apps/farsi_textcaptcha/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.farsi_textcaptcha.sock"
worker_processes 2
timeout 30
