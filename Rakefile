# encoding: UTF-8
require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake'

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Drop the database in the Rails app used for testing'
task :clean do
  `rm -r spec/dummy/db/migrate`
  `cd spec/dummy && rake db:drop RAILS_ENV=test`
end
