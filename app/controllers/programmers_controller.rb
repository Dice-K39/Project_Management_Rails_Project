class ProgrammersController < ApplicationController
    def index
        @programmers = Programmer.all
    end

    def new
        @programmer = Programmer.new
    end

    def create
        programmer = Programmer.new(programmer_params)

        if programmer.save
            redirect_to programmer_path(programmer)
        else
            render :new
        end
    end

    def show
        @programmer = find_programmer
    end

    def update
        @programmer = find_programmer
    end

    private

    def programmer_params
        params.require(:programmer).permit(:username, :password, :password_confirmation, :first_name, :last_name, :email, :phone_number)
    end

    def find_programmer
        Programmer.find_by_id(params[:id])
    end
end
