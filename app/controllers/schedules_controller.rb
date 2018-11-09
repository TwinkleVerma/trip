class SchedulesController < ApplicationController

  def index
    @flight = Flight.find_by({id: params[:flight_id]})
    @schedule = @flight.schedules
    if params[:user].present?
      @schedule = @schedule & current_user.flights.find(params[:flight_id]).schedules
    end
    authorize! :read, Schedule, @schedule
  end

  def calendar
    @airline = Airline.all
  end

  def event
    event_json = []
    @airline = Airline.all
    Flight.all.each do |flight|
      bg_color = case flight.airline.name
      when 'indigo'
        'red'
      when 'jetairways'
        'orange'
      when 'spicejet'
        'blue'
      else
        'darkslategray'
      end
      flight.schedules.each do |schedule|
        disable = DisableSchedule.where({schedule_id: schedule.id})
        date = get_date(schedule.day)
        if disable.present?
          disable.each do |dis|
           date.delete(dis.date.to_date) if date.include?(dis.date.to_date)
          end
        end
        date.each do |i|
          eve = {
            title: flight.number,
            start: (i.to_s+" "+schedule.depart_time.strftime("%H:%M")).to_datetime,
            end: (i.to_s+" "+schedule.arrival_time.strftime("%H:%M")).to_datetime,
            color: bg_color,
            description: schedule.id
          }
          event_json << eve
        end
      end
    end
    render json: event_json
  end

  def get_date(day)
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    my_days = [Schedule.scheduledays[day]]
    (start_date..end_date).to_a.select {|k| my_days.include?(k.wday)}
  end
end
