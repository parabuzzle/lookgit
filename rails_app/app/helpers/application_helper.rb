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
    
    def repo_lookup_by_uid(uid)
      @repo = Repodb.find(:all, :conditions => "owner_id = #{uid}")
    end
    
    def repo_lookup_by_rid(rid)
      @repo = Repodb.find(rid)
    end
    
    def watched_repo_lookup(uid)
      @watch = Watcher.find(:all, :conditions => "user_id = #{uid}")
    end
    
    def watched?(rid)
      watch = Watcher.find(:all, :conditions => "repo_id = #{rid} AND user_id = #{user?.id}")
      if watch != nil || ''
        return true
      else
        return false
      end
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
