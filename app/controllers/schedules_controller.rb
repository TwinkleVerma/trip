class SchedulesController < ApplicationController
  before_action :find_airline, only: [:calendar, :event]

  def index
    @flight = Flight.find_by({id: params[:flight_id]})
    if params[:user].present?
      @schedule = Schedule.joins('inner join crews on schedules.flight_id = crews.flight_id and crews.flight_id = '+params[:flight_id]+' and crews.user_id = '+params[:user])
    else
      @schedule = @flight.schedules
    end
    authorize! :read, Schedule, @schedule
  end

  def calendar
  end

  def event
    event_json = []
    Flight.all.each do |flight|

      user_array = flight.users.select_field("name").map {|p| p.name}.join(', ')
      user_array = "<b style='color: red'>Not Assgined</b>" if !user_array.present?

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

      flight.schedules.include_model(:disable_schedules).each do |schedule|
        disable = schedule.disable_schedules
        date = get_date(schedule.day)
        if disable.present?
          disable.each do |dis|
           date.delete(dis.date.to_date) if date.include?(dis.date.to_date)
          end
        end

        date.each do |i|
          eve = {
            title: flight.number,
            start: (i.to_s+' '+schedule.depart_time.strftime('%H:%M')).to_datetime,
            end: (i.to_s+' '+schedule.arrival_time.strftime('%H:%M')).to_datetime,
            color: bg_color,
            description: schedule.id,
            data: {
              flight_number: flight.number.upcase,
              flight_source: flight.source.capitalize,
              flight_destinition: flight.destinition.capitalize,
              flight_airline: flight.airline.name.upcase,
              schedule_day: schedule.day.capitalize,
              schedule_depart_time: schedule.depart_time.strftime('%H:%M'),
              schedule_arrival_time: schedule.arrival_time.strftime('%H:%M'),
              user: user_array
            }
          }
          event_json << eve
        end
      end
    end
    render json: event_json
  end

  protected

  def get_date(day)
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    days = [Schedule.scheduledays[day]]
    (start_date..end_date).to_a.select {|k| days.include?(k.wday)}
  end

  def find_airline
    @airline = Airline.all
  end
end
