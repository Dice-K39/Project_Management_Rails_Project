class SessionsController < ApplicationController

    def new
        if_logged_in_redirect_to_programmer_home
    end

    def create
        if_logged_in_redirect_to_programmer_home

        programmer = Programmer.find_by(username: params[:session][:username])

        if programmer && programmer.authenticate(params[:session][:password])
            session[:programmer_id] = programmer.id

            programmer.update_attribute(:last_login, DateTime.now)

            redirect_to programmer_path(programmer)
        else
            flash[:no_account] = 'Invalid username/password combination'

            render :new
        end
    end

    def login_by_github
        if_logged_in_redirect_to_programmer_home

        request.env['omniauth.auth']

        session[:name] = request.env['omniauth.auth']['info']['nickname']
        programmer = Programmer.find_by(username: session[:name])

        if programmer != nil
            session[:programmer_id] = programmer.id

            programmer.update_attribute(:last_login, DateTime.now)

            redirect_to programmer_path(programmer)
        else
            redirect_to new_programmer_path
        end
    end

    def destroy
        if_not_logged_in_redirect_to_login

        session.clear

        redirect_to '/'
    end
end
