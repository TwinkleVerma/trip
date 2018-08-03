class FlightsController < ApplicationController
  before_action :authenticate_user!
  def index
    @flight = Flight.all
  end

  def find
    source = params[:source].capitalize
    destinition = params[:destinition].capitalize
    if params[:date].to_datetime.monday?
      day = "monday"
    elsif params[:date].to_datetime.tuesday?
      day = "tuesday"
    elsif params[:date].to_datetime.wednesday?
      day = "wednesday"
    elsif params[:date].to_datetime.thursday?
      day = "thursday"
    elsif params[:date].to_datetime.friday?
      day = "friday"
    elsif params[:date].to_datetime.saturday?
      day = "saturday"
    elsif params[:date].to_datetime.sunday?
      day = "sunday"
    end
    @flight = Flight.joins("inner join schedules on schedules.id = flights.id and flights.source = '#{source}' and flights.destinition = '#{destinition}' and schedules.day = '#{day}'")  
  end
end
