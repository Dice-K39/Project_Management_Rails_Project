class PagesController < ApplicationController
    skip_before_action :if_not_logged_in_redirect_to_login
    
    # For home page
    def index
    end
end
