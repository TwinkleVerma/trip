class FlightsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:user].present? && params[:flight].present? && params[:airline_id].present?
      schedule = Airline.find_by(id: params[:airline_id]).flights.find_by(id: params[:flight]).schedules - User.find_by(id: params[:user]).flights.find_by(id: params[:flight]).schedules | User.find_by(id: params[:user]).flights.find_by(id: params[:flight]).schedules - Airline.find_by(id: params[:airline_id]).flights.find_by(id: params[:flight]).schedules
      @airline = Airline.find_by(id: params[:airline_id])
    else
      if params[:airline_id].present?
        @airline = Airline.find_by(id: params[:airline_id])
        @flight = @airline.flights
      else
        @flight = current_user.flights
      end
      authorize! :read, Flight, @flight
    end
  end

  def show
    if params[:airline_id].present?
      @airline = Airline.find_by(id: params[:airline_id])
      @flight = @airline.flights
    else
      @flight = current_user.flights
    end
    authorize! :read, Flight, @flight
  end

end
