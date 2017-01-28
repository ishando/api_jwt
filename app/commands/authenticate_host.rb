class AuthenticateHost
  prepend SimpleCommand

  def initialize(name, password)
    @name = name
    @password = password
  end

  def call
    JsonWebToken.encode(host_id: host.id) if host
  end

  private
  attr_accessor :name, :password

  def host
    host = Host.find_by_name(name)
    return host if host && host.authenticate(password)

    errors.add :host_authentication, 'invalid credentials'
    nil
  end

end
