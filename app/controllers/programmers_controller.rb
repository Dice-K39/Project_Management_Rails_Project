class ProgrammersController < ApplicationController
    before_action :if_not_logged_in_redirect_to_login, except: [:new, :create]
    before_action :if_logged_in_redirect_to_programmer_home, only: [:new, :create]
    before_action :find_programmer, only: [:show, :edit, :update, :destroy]

    def index
        if params[:query]
            @programmers = Programmer.programmer_search(params[:query])
        else
            @programmers = Programmer.all
        end
    end

    def new
        @programmer = Programmer.new
    end

    def create
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
        does_programmer_exist?(params[:id])
    end

    def edit
        does_programmer_exist?(params[:id])
    end

    def update
        does_programmer_exist?(params[:id])

        if @programmer.update(programmer_params)
            last_login_and_redirect(@programmer)
        else
            render :edit
        end
    end

    def destroy
        does_programmer_exist?(params[:id])

        if @programmer.delete
            redirect_to '/'
        else
            redirect_to programmer_path(@programmer)
        end
    end

    private

    def programmer_params
        params.require(:programmer).permit(:username, :password, :password_confirmation, :first_name, :last_name, :email, :phone_number, :is_project_manager)
    end

    def last_login_and_redirect(programmer)
        programmer.update_attribute(:last_login, DateTime.now)
        counting_logins(programmer)

        redirect_to programmer_path(programmer)
    end

    def does_programmer_exist?(id)
        exist = Programmer.find_by_id(id)

        if exist == nil
            flash[:dont_exist] = 'No record in database.'

            redirect_to programmers_path
        end
    end

    def redirect_to_programmers_if_not_project_manager
        if current_programmer.is_project_manager != true
            flash[:not_admin] = "Only Project Manager has access."

            redirect_to programmer_path(current_programmer)
        end
    end

    def find_programmer
        @programmer = Programmer.find_by_id(params[:id])
    end
end
