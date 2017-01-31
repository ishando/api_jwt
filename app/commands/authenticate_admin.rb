class AuthenticateAdmin
  prepend SimpleCommand

  def initialize(username, password, client_name)
    @username = username
    @password = password
    @client_name = client_name
  end

  def call
    if admin

      command = AuthenticateClient.call(@client_name)

      if command.success?
        return command.result
      else
        return command.errors
      end
    end

  end


  private
  attr_accessor :name, :password

  def admin
    admin = Admin.find_by_username(@username)
    return admin if admin && admin.authenticate(@password)

    errors.add :admin_authentication, 'invalid credentials'
    nil
  end

end
