source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 6.1.5"

gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.6"
gem "bcrypt", "~> 3.1"
gem "jwt", "~> 2.3"
gem "simple_command", "~> 0.1.0"

gem "byebug", "~> 11.1", :groups => [:development, :test]
gem "rspec-rails", "~> 5.1", :groups => [:development, :test]
gem "factory_bot_rails", "~> 6.2", :groups => [:development, :test]

gem "listen", "~> 3.7", :group => :development
gem "spring", "~> 2.1", :group => :development
gem "spring-watcher-listen", "~> 2.0", :group => :development
