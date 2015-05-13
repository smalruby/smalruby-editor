module SessionsHelper
  # whether signed in or not.
  def signed_in?
    session[:username]
  end
end
