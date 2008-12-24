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
    if params[:branch] == nil then redirect_to :action => 'show', :type => 'tree', :branch => 'master' end
    @additional_styles = 'repo'
    @repo = repo?
    username = params[:username]
    @title = "#{SITE_PROPS['sitename']} :: #{@repo.name}"
    @repopath = full_repo_path(@repo.loc, username)
    @git = Repo.new(@repopath)
    @privateurl = SITE_PROPS["gituser"] + '@' + SITE_PROPS["privatehost"] + ':' + @repo.user.username + '/' + @repo.unixname + '.git'
    @publicurl = SITE_PROPS["publicurl"] + '/' + @repo.user.username + '/' + @repo.unixname + '.git'
    @branch = @git.tree(params[:branch])
    @path = params[:path]
    @tags = @git.tags
    if @path != nil
      @tree = traverse(@branch, @path)
    else
      @tree = @branch
    end
  end
  
  def commits
    @additional_styles = 'repo'
    @repo = repo?
    @title = "#{SITE_PROPS['sitename']} :: #{@repo.name} :: Commits"
    username = params[:username]
    @repopath = full_repo_path(@repo.loc, username)
    @git = Repo.new(@repopath)
    @privateurl = SITE_PROPS["gituser"] + '@' + SITE_PROPS["privatehost"] + ':' + @repo.user.username + '/' + @repo.unixname + '.git'
    @publicurl = SITE_PROPS["publicurl"] + '/' + @repo.user.username + '/' + @repo.unixname + '.git'
    @branch = @git.tree(params[:branch])
    @path = params[:path]
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
      @repo = repo?
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
