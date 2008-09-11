class SiteController < ApplicationController
  
  
  def index
    @additional_styles = 'site'
    @title = SITE_PROPS['sitename']
  end
  
end
