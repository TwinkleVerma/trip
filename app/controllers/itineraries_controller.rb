class ItinerariesController < ApplicationController
  
  def index
    source = params[:source].capitalize
    destinition = params[:destinition].capitalize
    day = params["date"].to_date.strftime("%A").downcase
    if params[:date] >= Time.now.strftime("%F")
      @itineraries = Flight.joins("inner join schedules on schedules.id = flights.id and flights.source = '#{source}' and flights.destinition = '#{destinition}' and schedules.day = '#{day}'")
      @searchDate = params[:date]
    else
      @itineraries = "old"
      @searchDate
    end
  end

end
