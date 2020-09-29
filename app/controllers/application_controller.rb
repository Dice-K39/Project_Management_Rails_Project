class ApplicationController < ActionController::Base
    helper_method :is_logged_in?, :current_programmer, :if_logged_in_redirect_to_programmer_home, :if_not_logged_in_redirect_to_login

    def is_logged_in?
        !!current_programmer
    end

    def current_programmer
        @curret_programmer ||= Programmer.find_by_id(session[:programmer_id]) if session[:programmer_id]
    end

    def if_logged_in_redirect_to_programmer_home
        if is_logged_in?
            redirect_to programmer_path(session[:programmer_id])
        end
    end

    def if_not_logged_in_redirect_to_login
        if !is_logged_in?
            redirect_to login_path
        end
    end
end
