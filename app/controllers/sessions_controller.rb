# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def new; end

  def create
    if @user&.authenticate(session_params.require(:password))
      login @user
      session_params.require(:remember_me) == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find_by(email: session_params.require(:email).downcase)
  end

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end
end
