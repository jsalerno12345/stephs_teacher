# app/controllers/admin/schedules_controller.rb
module Admin
  class Admin::DashboardController < Admin::BaseController
    before_action :set_schedule, only: %i[edit update destroy]

    def index
      @schedules = Schedule.all
      @schedules = Schedule.order(:day_of_week, :start_time)
    end

    def new
      @schedule = Schedule.new
    end

    def edit
    end

    def create
      @schedule = Schedule.new(schedule_params)
      if @schedule.save
        redirect_to admin_schedules_path, notice: "Schedule slot created successfully!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @schedule.update(schedule_params)
        redirect_to admin_schedules_path, notice: "Schedule updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @schedule.destroy
      redirect_to admin_schedules_path, notice: "Schedule slot deleted."
    end

    private

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def schedule_params
      params.require(:schedule).permit(:day_of_week, :start_time, :end_time, :activity)
    end
  end
end
