class DisableSchedulesController < ApplicationController
  def create
    schedule = Schedule.find_by(id: params[:schedule_id])
    disable_schedule = schedule.disable_schedules.new({date: params[:date]})
    flash[:danger] = "Schedule on #{params[:date]} deleted"
    disable_schedule.save
    redirect_to calendar_path
  end
end
