class PagesController < ApplicationController
  before_action :authenticate_user!, only: :contact
  before_action :validate_location, only: :contact
  def home
  end

  def about
  end

  def contact
  end
end
