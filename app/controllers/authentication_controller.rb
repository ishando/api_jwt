class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
#    command = AuthenticateHost.call(params[:name], params[:password])
    command = AuthenticateApp.call(params[:name])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

end

#curl -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJob3N0X2lkIjoxLCJleHAiOjE0ODU2NjA4NzZ9.hgxqMlFEHukbBJs39yM51j2CbnBO8GOKITRzxjwTHLU" http://localhost:3000/items
