class WelcomeController < ApplicationController
  def index
    puts User.koala(session[:user_id]) if session[:user_id]
  end
end
