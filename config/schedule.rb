# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env

set :output, 'log/crontab.log'

every 2.hour do
  rails 'mast:mastdn_crawl'
end
every 2.hour do
  rails 'mast:nico_crawl'
end
every 2.hour do
  rails 'mast:pawoo_crawl'
end

every 2.hour do
  rails 'mast:mastdn_update_crawl'
end
every 2.hour do
  rails 'mast:nico__update_crawl'
end
every 2.hour do
  rails 'mast:mastdn_update_crawl'
end

every  3.hour do
  rails 'tweet_prof:prof_update'
end

every  2.days do
  rails 'tweet_prof:prof_update'
end
