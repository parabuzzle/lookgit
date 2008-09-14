# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #Return true if some user is logged in, false otherwise
    def logged_in?
      not session[:user_id].nil?
    end
    
    def sitename?
      return SITE_PROPS['sitename']
    end

    def user?
      @user = User.find(session[:user_id])
    end
    
    def user_lookup(id)
      @user = User.find(id)
    end
    
    def repo?
      @repo = Repodb.find(params[:id])
    end
    
    def watching_repo?(rid)
      @watching = Repodb.find(rid).watchers.count(:conditions => "user_id = #{session[:user_id]}")
    end
    
    def super_admin?
      user?.is_super_admin
    end
    
    def admin?
      user?.is_admin
    end
    
    def lead?
      user?.is_lead
    end

    # Return a link for use in layout navigation
    def nav_link(text, controller, action="index", rel=false)
      return link_to_unless_current(text, :controller => controller, :action => action, :rel => rel)
    end
  
end
