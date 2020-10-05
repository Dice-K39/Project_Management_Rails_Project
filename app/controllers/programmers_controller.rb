class ProgrammersController < ApplicationController
    def index
        if_not_logged_in_redirect_to_login
        
        @currently_logged_in_programmer = current_programmer
        @programmers = Programmer.all
    end

    def new
        if_logged_in_redirect_to_programmer_home

        @programmer = Programmer.new
    end

    def create
        if_logged_in_redirect_to_programmer_home

        @programmer = Programmer.new(programmer_params)

        if @programmer.valid?
            @programmer.save

            session[:programmer_id] = @programmer.id

            @programmer.login_count = 0

            last_login_and_redirect(@programmer)
        else
            render :new
        end
    end

    def show
        if_not_logged_in_redirect_to_login

        @programmer = Programmer.find_by_id(params[:id])
    end

    def edit
        if_not_logged_in_redirect_to_login

        @programmer = Programmer.find_by_id(params[:id])
    end

    def update
        if_not_logged_in_redirect_to_login

        @programmer = Programmer.find_by_id(params[:id])

        if @programmer.update(programmer_params)
            last_login_and_redirect(@programmer)
        else
            render :edit
        end
    end

    def destroy
        if_not_logged_in_redirect_to_login
        
        programmer = Programmer.find_by_id(params[:id])

        if programmer.delete
            redirect_to '/'
        else
            redirect_to programmer_path(programmer)
        end
    end

    private

    def programmer_params
        params.require(:programmer).permit(:username, :password, :password_confirmation, :first_name, :last_name, :email, :phone_number, :is_project_manager)
    end

    def last_login_and_redirect(programmer)
        programmer.update_attribute(:last_login, DateTime.now)
        programmer.update_attribute(:login_count,programmer.login_count + 1)

        redirect_to programmer_path(programmer)
    end
end
