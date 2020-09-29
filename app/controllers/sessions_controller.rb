class SessionsController < ApplicationController
    helper_method :is_logged_in?, :current_programmer

    def new
    end

    def create
        programmer = Programmer.find_by(username: params[:session][:username])

        if programmer && programmer.authenticate(params[:session][:password])
            session[:programmer_id] = programmer.id
byebug
            redirect_to programmer_path(programmer)
        else
            flash[:no_account] = 'Invalid username/password combination'

            render :new
        end
    end

    def destroy
        if is_logged_in?
            session.clear

            redirect_to '/'
        end
    end
end
