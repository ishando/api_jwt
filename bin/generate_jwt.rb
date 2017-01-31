#!/usr/bin/env ruby
require "rails"
require 'active_record'
require 'jwt'

# path to your application root.
APP_ROOT = Pathname.new File.expand_path('../../',  __FILE__)
@environment = ENV['RACK_ENV'] || 'development'
@dbconfig = YAML.load(File.read('config/database.yml'))[@environment]
@secrets = YAML.load(File.read('config/secrets.yml'))[@environment]

ActiveRecord::Base.establish_connection @dbconfig

class Client < ActiveRecord::Base
end

ARGV.each do|c|
  puts "checking #{c}..."

  client = Client.find_by_name(c)
  if client.nil?
    puts "#{c}: Not a valid client"
  else
    payload = { client_id: client.id, iat: client.created_at, iss: 'notify' }
    token = JWT.encode(payload, @secrets["secret_key_base"])
    puts "#{c}: auth_token = #{token}"
  end
end
