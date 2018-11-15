class AirlinesController < ApplicationController

  def index
    @airline = Airline.all
    if params[:user].present?
      @user = User.find_by(id: params[:user])
    end
    authorize! :read, Airline, @airline
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @airline = Airline.find_by(id: params[:id])
    if @airline.present?
      authorize! :show, @airline
      @airline.flights.each do |flight|
        @flights = Flight.joins(:users).flight_id(flight.id).distinct
        if !@flights.present?
          authorize! :show , @flights
        end
      end
    end
  end

end
