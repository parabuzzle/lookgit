class RepoController < ApplicationController
  include ApplicationHelper
  include RepoHelper  
  include Grit
  before_filter :protect, :only =>[:new]
  
  def index
    @additional_styles = 'repo'
    @title = "#{SITE_PROPS['sitename']} :: Public Repositories"
    #@repos = Repodb.find :all
    @repos = Repodb.public?
  end
  
  def show
    @additional_styles = 'repo'
    @repo = repo?
    username = params[:username]
    @title = "#{SITE_PROPS['sitename']} :: #{@repo.name}"
    @repopath = full_repo_path(@repo.loc, username)
    @git = Repo.new(@repopath)
  end
  
  def new
    @additional_styles = 'repo'
    @title = "#{SITE_PROPS['sitename']} :: Add Repository"
    
    if request.post?
      user = user?
      @repo = user.repodbs.new(params[:repo])
      @repo[:creator_id] = user.id
      @repo[:unixname] = @repo[:name].downcase
      @repo[:loc] = @repo[:unixname] + '.git'
      if @repo.save
        flash[:notice] = "Repository #{@repo.name} Created!"
        create_new_repo(@repo.loc, user.username)
        #redirect_to :controller => 'user', :action => 'index'
        redirect_to :controller => 'repo', :action => 'show', :username => user.username, :reponame => @repo.unixname
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
