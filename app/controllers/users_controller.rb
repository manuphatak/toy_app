# frozen_string_literal: true

class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  # GET /users
  # GET /users.json
  def index
    @users = @users.page(params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @microposts = @user.microposts.with_attached_image.page(params[:page])
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      @user.destroy
      format.html { redirect_to users_url, flash: { success: 'User was successfully destroyed.' } }
      format.json { head :no_content }
    end
  end
end
