class RepoController < ApplicationController
  include ApplicationHelper
  before_filter :protect, :only => [:add]
  
  def index
    @additional_styles = 'repo'
    @title = "#{SITE_PROPS['sitename']} :: Public Repositories"
    @repos = Repodb.find :all
  end
  
  def add
    @additional_styles = 'repo'
    @title = "#{SITE_PROPS['sitename']} :: Add Repository"
    
    if request.post?
      @repo = Repodb.new(params[:repo])
      @repo[:loc] = "missing right now"
      @repo[:creator_id] = 1
      @repo[:owner_id] = 1
      if @repo.save
        flash[:notice] = "User #{@repo.name} Created!"
        redirect_to :controller => 'repo', :action => 'show', :id => @repo.id
      else
        flash[:error] = "oops"
      end
    end
    
  end

  #protect a page from unauth access
  def protect
    unless logged_in?
      session[:protected_page] = request.request_uri
      flash[:notice] = "i can't do that dave... you must be logged in first"
      redirect_to :controller => "user", :action => "login"
      return false
    end
  end

end
