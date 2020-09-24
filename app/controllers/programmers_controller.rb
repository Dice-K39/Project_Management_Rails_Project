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
            update_time_and_redirect(programmer)
        else
            render :new
        end
    end

    def show
        find_programmer
    end

    def edit
        find_programmer
    end

    def update
        programmer = Programmer.find_by_id(params[:id])

        if programmer.update(programmer_params)
            update_time_and_redirect(programmer)
        else
            render :edit
        end
    end

    def destroy
        find_programmer

        if @programmer.delete
            redirect_to '/'
        else
            flash[:cannot_delete] = "Error. Account not deleted."

            redirect_to programmer_path(@programmer)
        end
    end

    private

    def programmer_params
        params.require(:programmer).permit(:username, :password, :password_confirmation, :first_name, :last_name, :email, :phone_number)
    end

    def find_programmer
        @programmer = Programmer.find_by_id(params[:id])
    end

    def update_time_and_redirect(programmer)
        programmer.update_attribute(:updated_at, DateTime.now)

        redirect_to programmer_path(programmer)
    end
end
