class ItinerariesController < ApplicationController

  include ItinerariesHelper

  def index
    @itineraries = filter_flights
  end
end
