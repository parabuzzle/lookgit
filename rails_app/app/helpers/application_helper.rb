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

    # Return a link for use in layout navigation
    def nav_link(text, controller, action="index", rel=false)
      return link_to_unless_current(text, :controller => controller, :action => action, :rel => rel)
    end
  
end
