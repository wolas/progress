class WelcomeController < ApplicationController

  def index
    redirect_to account_url if logged_in?
  end

  def secure?
    false
  end
end
