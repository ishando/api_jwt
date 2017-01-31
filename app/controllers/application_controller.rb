class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_appl

  private

  def authenticate_request
    @current_client = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_appl
  end

end
