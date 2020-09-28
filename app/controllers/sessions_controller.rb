class SessionsController < ApplicationController
    def new
    end

    def create
        programmer = Programmer.find_by(username: params[:session][:username])
        byebug
        if programmer && programmer.authenticate(params[:session][:password])
            byebug
            redirect_to programmer_path(programmer)
        else
            flash[:no_account] = 'Invalid username/password combination'

            render :new
        end
    end
end
