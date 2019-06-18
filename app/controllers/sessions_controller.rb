# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: session_params.require(:email).downcase)
    if user&.authenticate(session_params.require(:password))
      login user
      session_params.require(:remember_me) == '1' ? remember(user) : forget(user)
      redirect_to user
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

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end
end
