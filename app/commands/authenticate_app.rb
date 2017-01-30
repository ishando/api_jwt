class AuthenticateApp
  prepend SimpleCommand

#  def initialize(name, password)
#    @name = name
#    @password = password
#  end

  def initialize(name)
    @name = name
  end

  def call
    JsonWebToken.encode(app_id: appl.id) if appl
  end

  private
  attr_accessor :name, :password

  def appl
    appl = App.find_by_name(name)
    return appl if appl  # && appl.authenticate(password)

    errors.add :app_authentication, 'invalid credentials'
    nil
  end

end
