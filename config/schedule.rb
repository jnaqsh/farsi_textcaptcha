set :output, File.join(path, "log", "cron.log")

every :week do
  command "cd #{path} && RAILS_ENV=#{environment} backup perform --trigger db_backup --config_file config/backup.rb --data-path db --log-path log --tmp-path tmp"
end
