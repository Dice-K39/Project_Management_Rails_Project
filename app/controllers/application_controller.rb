class ApplicationController < ActionController::Base
    helper_method :is_logged_in?, :current_programmer

    def is_logged_in?
        !!current_programmer
    end

    def current_programmer
        @curret_programmer ||= Programmer.find_by_id(session[:programmer_id]) if session[:programmer_id]
    end
end
