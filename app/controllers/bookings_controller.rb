class BookingsController < ApplicationController
  include ApplicationHelper
  def new
    @booking = Booking.new
    @user_id = params[:user_id]
    @schedule = Schedule.find(params[:schedule])
    @cost = params[:cost]
    @flight = Flight.find(params[:flight])
    @date = params[:date]
  end

  def index
    @booking = Booking.where(user_id: params[:user_id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
  end

  def create

    if params.present?
      @booking = Booking.new({date: params[:date], cost: params[:cost].to_i, schedule_id: params[:schedule], user_id: params[:user_id]})
      if @booking.save!
        flash[:success] = "Your Flight has been booked"
      else
        flash[:danger] = "Your Flight has not been booked"
        redirect_to root_path
      end
    else
      flash[:danger] = "Your Flight has not been booked"
      redirect_to root_path
    end
  end

  def update
    if params[:id].present?
      @booking = Booking.find(params[:id])
      if @booking.update!(status: Booking.statuses[:canceled])
      else
        flash[:danger] = "Your booking has been canceled"
        redirect_to user_bookings_path(current_user)
      end
    else
      flash[:danger] = "Can not cancel your booking"
      redirect_to user_bookings_path(current_user)
    end
  end

  def show
    @booking = Booking.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        send_data pdf, :filename => @booking.id.to_s+ ".pdf",
               :type => "application/pdf",
               :disposition => "attachment"
      end
    end
  end

end
