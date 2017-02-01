#!/usr/bin/env ruby
require "rails"
require 'active_record'
require 'jwt'


# path to your application root.
APP_ROOT = Pathname.new File.expand_path('../../',  __FILE__)
CURR_ENV = Rails.env || 'development'
DBCONFIG = YAML.load(File.read('config/database.yml'))[CURR_ENV]
puts DBCONFIG

ActiveRecord::Base.establish_connection DBCONFIG

class GenerateJwt
  class Client < ActiveRecord::Base
  end

  def initialize(name)
    puts CURR_ENV
    secrets = YAML.load(File.read('config/secrets.yml'))[CURR_ENV]["secret_key_base"]
    client = Client.find_by_name(name)
    if client.nil?
      @auth = nil
    else
      payload = { client_id: client.id, iat: client.created_at, iss: 'notify' }
      @auth = JWT.encode(payload, secrets)
    end
  end

  def get_auth
    return @auth
  end
end

