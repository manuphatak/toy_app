# frozen_string_literal: true

class MicropostsController < ApplicationController
  load_and_authorize_resource

  # GET /microposts
  # GET /microposts.json
  def index
    @microposts = @microposts.page(params[:page]).includes(:user)
  end

  # POST /microposts
  # POST /microposts.json
  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    respond_to do |format|
      if @micropost.save
        format.html { redirect_to root_path, flash: { success: 'Micropost created!' } }
        format.json { render :show, status: :created, location: @micropost }
      else
        format.html do
          @microposts = current_user.microposts.page(params[:page])
          render 'static_pages/home'
        end
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to root_path, flash: { success: 'Micropost was successfully destroyed.' } }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def micropost_params
    params.require(:micropost).permit(:content, :user_id)
  end
end
