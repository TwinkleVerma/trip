class ItinerariesController < ApplicationController

  include ItinerariesHelper


  def index
    @source = params[:source].downcase
    @destinition = params[:destinition].downcase
    @date = params[:date]
    @day = @date.to_date.strftime("%A").downcase
    @itineraries = filter_filghts 
  end
end