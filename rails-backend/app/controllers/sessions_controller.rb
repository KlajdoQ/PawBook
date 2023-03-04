class SessionsController < ApplicationController

 # skip_before_action :authorized_user

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user.as_json(only: [:id, :email, :full_name]), status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    head :no_content
  end



end

