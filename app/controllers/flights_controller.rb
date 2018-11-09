class FlightsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:user].present? && params[:flight].present? && params[:airline_id].present?
      @schedule = Airline.find(params[:airline_id]).flights.find(params[:flight]).schedules - User.find(params[:user]).flights.find(params[:flight]).schedules | User.find(params[:user]).flights.find(params[:flight]).schedules - Airline.find(params[:airline_id]).flights.find(params[:flight]).schedules
      @airline = Airline.find(params[:airline_id])
      # @schedule = @airline.flights.find(params[:flight]).schedules
      respond_to do |format|
        format.js { render '/users/form.js.erb' }
      end
    else
      if params[:airline_id].present?
        @airline = Airline.find(params[:airline_id])
        @flight = @airline.flights
      else
        @flight = Flight.all
      end
      authorize! :read, Flight, @flights
    end
  end

  def show
    if params[:airline_id].present?
      @airline = Airline.find(params[:airline_id])
      @flight = @airline.flights
    else
      @flight = current_user.flights
    end
    authorize! :read, Flight, @flight
  end

end
