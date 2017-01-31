#!/usr/bin/env ruby
require "rails"
require 'active_record'
require 'jwt'

# path to your application root.
APP_ROOT = Pathname.new File.expand_path('../../',  __FILE__)
@environment = ENV['RACK_ENV'] || 'development'
@dbconfig = YAML.load(File.read('config/database.yml'))[@environment]
@@secrets = YAML.load(File.read('config/secrets.yml'))[@environment]

ActiveRecord::Base.establish_connection @dbconfig

class Client < ActiveRecord::Base
end

class GenerateJwt
  def initialize(name)
    client = Client.find_by_name(name)
    if client.nil?
      @auth = nil
    else
      payload = { client_id: client.id, iat: client.created_at, iss: 'notify' }
      @auth = JWT.encode(payload, @@secrets["secret_key_base"])
    end
  end

  def get_auth
    return @auth
  end
end

ARGV.each do|c|
  puts "checking #{c}..."
  token = GenerateJwt.new(c)

  if token.get_auth.nil?
    puts "#{c}: Not a valid client"
  else
    puts "#{c}: auth_token = #{token.get_auth}"
  end
end
