class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_host

  private

  def authenticate_request
    @current_host = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_host
  end

end
