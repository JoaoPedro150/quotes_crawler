class AuthController < ActionController::API

  # POST /auth/sign-in
  def sign_in
    user = User.where(username: params[:username]).first

    if user && user.authenticate(params[:password])
      render json: { authorization: authenticate(user._id) } 
    else
      head :unauthorized
    end
  end
  
  # POST /auth/sign-up
  def sign_up
    user = User.new(user_params)  

    if user.save
      render json:{ authorization: authenticate(user._id) }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  private
  def authenticate(valid_for_minutes = 5, user_id)
    payload = { 
      exp: Time.now.to_i + (valid_for_minutes*60),
      sub: user_id
    }
    'Bearer ' + (JWT.encode payload, ApplicationController::SERVER_KEY, 'HS256')
  end

  def user_params
    params.require(:auth).permit(:username, :password)
  end
end
