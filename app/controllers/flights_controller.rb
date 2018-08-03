class FlightsController < ApplicationController
  before_action :authenticate_user!
  def index
    @flight = Flight.all
  end
end
