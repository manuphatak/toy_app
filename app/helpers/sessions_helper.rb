# frozen_string_literal: true

module SessionsHelper

  def login(user)
    session[:user_id] = user.id

  end
end
