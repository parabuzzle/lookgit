class RepoController < ApplicationController
  include ApplicationHelper
  include RepoHelper  
  include Grit
  #before_filter :protect
  
  def index
    @additional_styles = 'repo'
    @title = "#{SITE_PROPS['sitename']} :: Public Repositories"
    #@repos = Repodb.find :all
    @repos = Repodb.public?
  end
  
  def show
    @addition_style = 'repo'
    @repo = repo?
    @title = "#{SITE_PROPS['sitename']} :: #{@repo.name}"
    @git = Repo.new(@repo.loc)
  end
  
  def new
    @additional_styles = 'repo'
    @title = "#{SITE_PROPS['sitename']} :: Add Repository"
    
    if request.post?
      user = user?
      @repo = user.repodbs.new(params[:repo])
      @repo[:loc] = SITE_PROPS['repospath'] + @repo[:name] + '.git'
      @repo[:creator_id] = user.id
      if @repo.save
        flash[:notice] = "Repository #{@repo.name} Created!"
        create_new_repo(@repo.loc)
        repo = Repo.new(@repo.loc)
        redirect_to :controller => 'user', :action => 'index'
        #redirect_to :controller => 'repo', :action => 'show', :id => @repo.id
      end
    end
    
  end
  
  def watch
    if request.post?
      if watch_a_repo(params[:repo_id])
        flash[:notice]= "Repository added to your watch list"
        redirect_to :controller => 'user', :action => 'index'
      else
        flash[:error] = "Something Broke"
      end
    else
      flash[:error] = "Can't do that"
      redirect_to :controller => 'user', :action => 'index'
    end
  end
  
  def unwatch
    if request.post?
      if unwatch_a_repo(params[:repo_id])
        flash[:notice]= "Repository removed from your watch list"
        redirect_to :controller => 'user', :action => 'index'
      else
        flash[:error] = "Something Broke"
      end
    else
      flash[:error] = "Can't do that"
      redirect_to :controller => 'user', :action => 'index'
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
