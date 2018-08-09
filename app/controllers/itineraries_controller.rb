class ItinerariesController < ApplicationController

  def index
    source = params[:source].capitalize
    destinition = params[:destinition].capitalize
    day = params["date"].to_date.strftime("%A").downcase
    @itineraries = Flight.joins(:schedules).where(source: source ,destinition: destinition ,schedules: {day: day}).includes(:schedules)
    @searchDate = params[:date]
  end
end
