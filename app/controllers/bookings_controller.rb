class BookingsController < ApplicationController
  
  def new
    @booking = Booking.new
    @user_id = params[:user_id]
    @schedule = params[:schedule]
    @cost = params[:cost]
    @flight = params[:flight]
    @date = params[:date]
  end
  
  def index
    @booking = Booking.where(user_id: params[:user_id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 1)
  end
  
  def create
    if params.present?
      @booking = Booking.new({date: params[:date], status: "confirmed", cost: params[:cost].to_i, schedule_id: params[:schedule_id], user_id: params[:user_id]})
      if @booking.save
        flash[:success] = "Your Flight has been booked"
        redirect_to root_path
      else
        flash[:danger] = "Your Flight has been booked"
        redirect_to root_path
      end
    else
      flash[:danger] = "Your Flight has been booked"
      redirect_to root_path
    end
  end

  def update
    if params[:id].present?
      @booking = Booking.find(params[:id])
      if @booking.update(status: "canceled")
        
      else
        flash[:danger] = "Your Flight has been booked"
        redirect_to user_bookings_path(current_user)
      end
    else
      flash[:danger] = "Your Flight has been booked"
      redirect_to user_bookings_path(current_user)
    end
  end

end
