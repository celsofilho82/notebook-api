class ApplicationController < ActionController::API

  # Travando para que a API somente responda as requisições que tiverem no header
  # o Media type "accept: application/json"
  before_action :ensure_json_request

  def ensure_json_request
    return if request.headers["Accept"] =~ /json/
    render :nothing => true, :status => 406
  end
  
end
