class FlightsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @itineraries = Flight.all
  end  
end
