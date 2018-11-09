class CrewsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @user.crews.create({flight_id: params[:flight]})
  end

  def destroy
    @user = User.find(params[:user_id])
    Crew.find_by({user_id: params[:user_id], flight_id: params[:flight]}).destroy
  end

end
