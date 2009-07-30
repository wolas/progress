class WelcomeController < ApplicationController

  def index
    redirect_to stories_url if logged_in?
  end

  def secure?
    false
  end
end
