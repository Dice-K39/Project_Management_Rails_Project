class ProgrammersController < ApplicationController
    before_action :if_not_logged_in_redirect_to_login, except: [:new, :create]
    before_action :if_logged_in_redirect_to_programmer_home, only: [:new, :create]
    before_action :find_programmer, only: [:show, :edit, :update, :destroy]
    before_action :checks_for_programmer, only: [:edit, :update, :destroy]

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
        does_programmer_exist?
    end

    def edit
    end

    def update
        if @programmer.update(programmer_params)
            redirect_to programmer_path(@programmer)
        else
            render :edit
        end
    end

    def destroy
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

    def does_programmer_exist?
        exist = Programmer.find_by_id(params[:id])

        if exist == nil
            flash[:dont_exist] = 'No record in database.'

            redirect_to programmers_path
        end
    end

    def can_change_info?
        if current_programmer.id != @programmer.id && !current_programmer.is_project_manager
            flash[:not_alloed_to_change_info] = 'No access.'

            redirect_to programmers_path
        end
    end

    def checks_for_programmer
        does_programmer_exist?

        can_change_info?
    end

    def find_programmer
        @programmer = Programmer.find_by_id(params[:id])
    end
end
