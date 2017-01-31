class AuthenticateClient
  prepend SimpleCommand

#  def initialize(name, password)
#    @name = name
#    @password = password
#  end

  def initialize(name)
    @name = name
  end

  def call
    JsonWebToken.encode(client_id: client.id, iat: client.created_at, iss: 'notify') if client
  end

  private
  attr_accessor :name, :password

  def client
    client = Client.find_by_name(name)
    return client if client  # && appl.authenticate(password)

    errors.add :client_authentication, 'invalid client'
    nil
  end

end
