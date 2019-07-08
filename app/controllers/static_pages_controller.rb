# frozen_string_literal: true

class StaticPagesController < ApplicationController
  skip_authorization_check
  def home; end

  def help; end

  def about; end

  def contact; end
end
