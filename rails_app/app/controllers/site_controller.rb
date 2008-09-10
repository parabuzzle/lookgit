class SiteController < ApplicationController
  
  def index
    @title = SITE_PROPS['sitename']
  end
  
end
