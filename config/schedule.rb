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

env :PATH, ENV['PATH']
env "GEM_HOME", ENV["GEM_HOME"]
set :output, "#{path}/log/cron.log"
set :chronic_options, :hours24 => true

every 1.day, :at => '19:10' do
  runner "ImportProductJob.perform_later"
end
every 1.day, :at => '19:20' do
  runner "ImportProductQuantityJob.perform_later"
end
every 1.day, :at => '19:50' do
  runner "Product.ebay_process"
end






every 1.day, :at => '08:10' do
  runner "ImportProductJob.perform_later"
end
every 1.day, :at => '08:20' do
  runner "ImportProductQuantityJob.perform_later"
end
every 1.day, :at => '08:50' do
  runner "Product.ebay_process"
end
