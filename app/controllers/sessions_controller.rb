class SessionsController < ApplicationController

    def new
        if_logged_in_redirect_to_programmer_home
    end

    def create
        if_logged_in_redirect_to_programmer_home

        programmer = Programmer.find_by(username: params[:session][:username])

        if programmer && programmer.authenticate(params[:session][:password])
            session[:programmer_id] = programmer.id

            redirect_to programmer_path(programmer)
        else
            flash[:no_account] = 'Invalid username/password combination'

            render :new
        end
    end

    def destroy
        if_not_logged_in_redirect_to_login

        session.clear

        redirect_to '/'
    end
end
