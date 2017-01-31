#!/usr/bin/env ruby
require File.expand_path('../../config/boot', __FILE__)
require "rails"
#require "active_model/railtie"
require 'active_record'
#require 'pathname'
require 'bcrypt'
require 'jwt'
require 'simple_command'
#require 'sequel'

# path to your application root.
APP_ROOT = Pathname.new File.expand_path('../../',  __FILE__)
@environment = ENV['RACK_ENV'] || 'development'
@dbconfig = YAML.load(File.read('config/database.yml'))
@secrets = YAML.load(File.read('config/secrets.yml'))

ActiveRecord::Base.establish_connection @dbconfig[@environment]

class Client < ActiveRecord::Base
end


class JsonWebToken
  class << self
    def encode(payload)
puts "jwt encode...#{JWT.inspect}"
      JWT.encode(payload, @secrets[@environment][secret_key_base])
    end
  end
end

class AuthenticateClient
puts "authClient..."
  prepend SimpleCommand

  def initialize(name)
puts "authClient initialize...#{name}"
    @name = name
  end

  def call
puts "authClient call...#{name}"
    if this_client = client
puts "authClient call jwt...#{JsonWebToken}"
      JsonWebToken.encode(client_id: this_client.id, iat: this_client.created_at, iss: 'notify')
    end
  end

  private
  attr_accessor :name, :password

  def client
puts "authClient client...#{name}"
    client = Client.find_by_name(name)
puts "authClient client...#{client.inspect}"
    return client if client  # && appl.authenticate(password)

    errors.add :client_authentication, 'invalid client'
    nil
  end

end

def authenticate(client_name)
puts "authenticate..."
  command = AuthenticateClient.call(client_name)

  if command.success?
    return "auth_token: #{command.result}"
  else
    return "error: #{command.errors}"
  end
end



ARGV.each do|c|
  puts "checking #{c}..."
  puts "#{c}: #{authenticate(c)}"
end

