class UserController < ApplicationController
  include ApplicationHelper
  before_filter :protect, :only => [:index, :edit]
  
  def index
    @title = "#{SITE_PROPS['sitename']} :: User Dashboard"
  end
 
  def logout
    User.logout!(session, cookies)
    flash[:notice] = "Logged out!"
    redirect_to :controller => "site", :action => "index"
  end
 
  def register
    @title = "#{SITE_PROPS['sitename']} :: Register"
    if param_posted?(:user)
      @user = User.new(params[:user])
      if @user.save
        @user.login!(session)
        flash[:notice] = "User #{@user.username} Created!"
        redirect_to_forwarding_url
      else
        @user.clear_password!
      end
    end
  end
 
  def login
    @title = "#{SITE_PROPS['sitename']} :: Login"
    if request.get?
      @user = User.new(:remember_me => remember_me_string)
    elsif param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_username_and_password(@user.username,@user.password)
      
      if user
        user.login!(session)
        if @user.remember_me? ? user.remember!(cookies) : user.forget!(cookies); end
        flash[:notice] = "User #{user.username} logged in!"
        redirect_to_forwarding_url
      else
        #Don't show the password in the view!
        @user.clear_password!
        flash[:notice] = "Invalid username/password combination"
      end
    end
  end
  
  #Edit user info
  def edit
    @title = "edit"
    @user = User.find(session[:user_id])
    if param_posted?(:user)
      if @user.update_attributes(params[:user])
        flash[:notice] = "Updated!"
        redirect_to :action => "index"
      end
    end
  end
  
  private
  
  #protect a page from unauth access
  def protect
    unless logged_in?
      session[:protected_page] = request.request_uri
      flash[:notice] = "i can't do that dave... you must be logged in first"
      redirect_to :action => "login"
      return false
    end
  end
  
  #Return true if a param to the given symbol was posted
  def param_posted?(symbol)
    request.post? and params[symbol]
  end
  
  #Redirect to the previously requested url (if present)...
  def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => "index"
    end
  end
  
  def remember_me_string
    cookies[:remember_me] || "0"
  end
end
