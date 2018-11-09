class DisableSchedulesController < ApplicationController
  def create
    schedule = Schedule.find(params[:schedule_id])
    disable_schedule = schedule.disable_schedules.new({date: params[:date]})
    disable_schedule.save
    redirect_to calendar_path
  end
end
