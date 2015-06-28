class LoginController < ApplicationController
  before_filter :set_user, only: [:create]

  def create
    render json: { jwt: AuthToken.issue_token({ user_id: @user.id }) }, status: :created
  end

private

  def set_user
    @user = User.find_by(username: login_params[:username])
    head :not_found unless @user.present? && @user.authenticate(login_params[:password])
  end

  def login_params
    params.require(:login).permit :username, :password
  end
end
