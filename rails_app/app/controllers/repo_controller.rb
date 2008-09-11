class RepoController < ApplicationController
  
  def index
    @additional_styles = 'repo'
    @title = "#{SITE_PROPS['sitename']} :: Public Repositories"
    @repos = Repo.find :all
  end
  
  def add
    @additional_styles = 'repo'
    @title = "#{SITE_PROPS['sitename']} :: Add Repository"
    
    if request.post?
      @repo = Repo.new(params[:repo])
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

end
