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
            programmer.update_attribute(:login_count,programmer.login_count + 1)

            redirect_to programmer_path(programmer)
        else
            flash[:no_account] = 'Invalid username/password combination'

            render :new
        end
    end

    def create_or_login_by_github
        if_logged_in_redirect_to_programmer_home

        programmer = Programmer.find_or_create_by(username: auth['info']['nickname']) do |p|
            byebug
            p.password = SecureRandom.hex(16)
            p.first_name = 'Enter First Name'
            p.last_name = 'Enter Last Name'
            p.email = 'Enter Email'
            p.phone_number = '1234567890'
            p.last_login = DateTime.now
            p.login_count = 0
            p.is_project_manager = true
        end

        session[:programmer_id] = programmer.id

        if programmer.login_count > 0
            programmer.update_attribute(:login_count,programmer.login_count + 1)

            redirect_to programmers_path
        else
            flash[:update_account] = "Please update account."
            
            programmer.update_attribute(:login_count,programmer.login_count + 1)

            redirect_to edit_programmer_path(programmer)
        end
    end

    def destroy
        if_not_logged_in_redirect_to_login

        session.clear

        redirect_to '/'
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end
