class CrewsController < ApplicationController
  before_action :find_user
  def create
    user.crews.create({flight_id: params[:flight]})
    flash[:success] = "Flight is allocated to user"
  end

  def destroy
    Crew.find_by({user_id: params[:user_id], flight_id: params[:flight]}).destroy
    flash[:danger] = "Flight is deallocated to user"
  end

  protected

  def find_user
    user = User.find_by(id: params[:user_id])
  end
end
