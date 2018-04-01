require 'thor'
require 'rsync'
require 'logger'

module Drive_sync

  class MyLog
    def self.log
      if @logger.nil?
        @logger = Logger.new "./log/back_log.log"
        @logger.level = Logger::INFO
        @logger.datetime_format = '%Y-%m-%d %H:%M:%S '
      end
      @logger
    end
  end

  class Sync < Thor

    namespace :drive_sync

    desc "back_up", "back up black to blue"
    def back_up
      puts "backing up black to blue"     
      Rsync.run("/Volumes/Black/", "/Volumes/Blue/", ['-a', '-v', '-h', '--log-format=FORMAT', '--delete']) do |result|
        if result.success?
          MyLog.log.info "Success"
          result.changes.each do |change|
            puts "changes"
            MyLog.log.info "#{change.filename} (#{change.summary})"
            puts "#{change.filename} (#{change.summary})"
          end
        else
          puts result.error
        end
end
    end
    
    

  end
end
