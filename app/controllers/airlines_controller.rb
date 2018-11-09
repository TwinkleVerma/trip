class AirlinesController < ApplicationController

  def index
    @airline = Airline.all
    if params[:user].present?
      @user = User.find(params[:user])
    end
    authorize! :read, Airline, @airline
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @airline = Airline.find(params[:id])
    if @airline.present?
      authorize! :show, @airline
      @flights = @airline.flights & current_user.flights
      if !@flights.present?
        authorize! :show , @flights
      end
    end
  end
end
