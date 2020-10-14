class ApplicationController < ActionController::Base
    helper_method :is_logged_in?, :current_programmer, :if_logged_in_redirect_to_programmer_home, :if_not_logged_in_redirect_to_login, :redirect_to_assignments_if_not_project_manager, :does_assignment_exist?, :counting_logins
    before_action :if_not_logged_in_redirect_to_login

    def is_logged_in?
        !!current_programmer
    end

    def current_programmer
        @curret_programmer ||= Programmer.find_by_id(session[:programmer_id]) if session[:programmer_id]
    end

    def if_logged_in_redirect_to_programmer_home
        if is_logged_in?
            flash[:already_logged_in] = "Already logged in."
            
            redirect_to programmer_path(session[:programmer_id])
        end
    end

    def if_not_logged_in_redirect_to_login
        if !is_logged_in?
            flash[:not_logged_in] = "Please login."

            redirect_to login_path
        end
    end

    def redirect_to_assignments_if_not_project_manager
        if current_programmer.is_project_manager != true
            flash[:not_admin] = "Only Project Manager has access."

            redirect_to assignments_path
        end
    end

    def does_assignment_exist?
        if params[:assignment_id]
            exist = Assignment.find_by_id(params[:assignment_id])
        else
            exist = Assignment.find_by_id(params[:id])
        end

        if exist == nil
            flash[:dont_exist] = 'No record in database.'

            redirect_to assignments_path
        end
    end

    def find_assignment
        if params[:assignment_id]
            @assignment = Assignment.find_by_id(params[:assignment_id])
        else
            @assignment = Assignment.find_by_id(params[:id])
        end
    end

    def counting_logins(programmer)
        programmer.update_attribute(:login_count,programmer.login_count + 1)
    end
end
