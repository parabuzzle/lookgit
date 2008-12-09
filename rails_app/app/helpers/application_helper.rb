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
      @repo = Repodb.find_by_unixname_and_user_id(params[:reponame], User.find_by_username(params[:username]).id)
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
    
    def full_repo_path(loc, user)
      return SITE_PROPS['repospath'] + '/' + user + '/' + loc
    end
    
    def traverse(branch, path)
      b = branch.clone
      path.each do |t|
        b = b./t
      end
      return b
    end
    
    def format_text(file_text)
      text = Syntaxi.new(file_text).process
      return text
    end
    
    def build_crumb(path, branch)
      basepath = Array.new
      url = nil
      if path != nil
        path.each do |p|
          if basepath.empty?
            basepath = p + "/"
            uri = URI.unescape(url_for( :path => basepath))
          else
            basepath << p + "/"
            uri = URI.unescape(url_for(:path => basepath))
          end
          
          if url == nil
            url = "<a href='#{url_for(:branch => branch)}'>#{branch}</a> / <a href='#{uri}'>#{p}</a>"
          else
            url = "#{url} / <a href='#{uri}'>#{p}</a>"
          end
        end
      else
       url = "<a href='#{url_for(:branch => branch)}'>#{branch}</a>"
      end
      return url
    end
    
    def build_uri(path, glob, type = 'tree')
      if path != nil
        basepath = path.clone
        uri = URI.unescape(url_for( :type => type, :path => basepath << glob))
        basepath = nil
      else
        uri = URI.unescape(url_for( :type => type, :path => glob))
      end
      return uri
    end

    # Return a link for use in layout navigation
    def nav_link(text, controller, action="index", rel=false)
      return link_to_unless_current(text, :controller => controller, :action => action, :rel => rel)
    end
    
    def reldate(date)
        #Makes utc dates relative to now.
        idate = date.to_i
        now = Time.now.to_i
        n = now - idate

        if n <= 60 #less than a minute
          return "#{n} seconds ago"

        elsif n < 3600 #less than an hour
          if n < 120
            return "about a minute ago"
          else
            n = n/60
            return "#{n} minutes ago"
          end

        elsif n < 86400 #less than a day
          if n < 7200
            return "about an hour ago"
          else
            n = n/3600
            return "#{n} hours ago"
          end

        elsif n < 604800 #less than a week
          if n < 172800
            return "about a day ago"
          else
            n = n/86400
            return "#{n} days ago"
          end

        elsif n < 2419200 #less than a month
          if n < 1209600
            return "about a week ago"
          else
            n = n/604800
            return "#{n} weeks ago"
          end

        elsif n < 31449600 #less than a year
          if n < 4838400
            return "about a month ago"
          else
            n = n/2419200
            return "#{n} months ago"
          end

        elsif n >= 31449600 #Greater than a year
          if 62899200
            return "last year"
          else
            n = n/31449600
            return "#{n} years ago"
          end
        else
          return date
        end
      end
  
end
