class ApplicationController < ActionController::API
  SERVER_KEY = Rails.application.secrets.secret_key_base. to_s

  def authorize
    authorization = request.headers['Authorization']
    authorization = authorization.split(' ').last if authorization

    begin
      JWT.decode(authorization, SERVER_KEY, true, algorithm: 'HS256')
    rescue JWT::DecodeError => e
      render json: { errors: [ e.message ] }, status: :unauthorized
    end
  end
end
