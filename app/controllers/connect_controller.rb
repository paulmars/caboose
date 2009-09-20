class ConnectController < ApplicationController

  def index
  end

  def logout
    session[:facebook_session] = nil
    redirect_to "/"
  end

end
