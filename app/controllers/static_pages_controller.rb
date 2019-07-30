# frozen_string_literal: true

class StaticPagesController < ApplicationController
  skip_authorization_check
  def home
    return unless user_signed_in?

    @microposts = current_user.feed.with_attached_image.includes(:user).page(params[:page])
  end

  def help; end

  def about; end

  def contact; end
end
