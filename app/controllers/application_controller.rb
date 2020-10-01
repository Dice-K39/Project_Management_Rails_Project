class ApplicationController < ActionController::Base
    helper_method :is_logged_in?, :current_programmer, :if_logged_in_redirect_to_programmer_home, :if_not_logged_in_redirect_to_login, :redirect_if_not_current_programmer, :if_not_admin

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
            flash[:not_logged_in] = "Please login."

            redirect_to login_path
        end
    end

    def redirect_if_not_current_programmer_or_project_manager(id)
      if current_programmer.id != id || current_programmer.is_project_manager
        flash[:not_assigned_or_current_programmer] = "No Access"

        redirect_to programmer_path(current_programmer)
      end
    end

    def if_not_project_manager
        if current_programmer.is_project_manager != true
            flash[:not_admin] = "Only Project Manager has access."

            redirect_to programmer_path(current_programmer)
        end
    end
end
