# frozen_string_literal: true

class RelationshipsController < ApplicationController
  load_and_authorize_resource

  # GET /relationships
  # GET /relationships.json
  def index
    respond_to do |format|
      format.html { @relationships = @relationships.includes(:follower, :followed).order(created_at: :desc).page(params[:page]) }
      format.json { @relationships = @relationships.order(created_at: :desc).page(params[:page]) }
    end
  end

  # POST /relationships
  # POST /relationships.json
  def create
    respond_to do |format|
      if @relationship.save
        format.html { redirect_to @relationship.followed, notice: "Now following #{@relationship.followed.name}." }
        format.json { render :show, status: :created, location: @relationship }
        format.js
      else
        format.html { render :index }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relationships/1
  # DELETE /relationships/1.json
  def destroy
    @relationship.destroy
    respond_to do |format|
      format.html { redirect_to @relationship.followed, notice: "No longer following #{@relationship.followed.name}." }
      format.json { head :no_content }
      format.js
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end
end