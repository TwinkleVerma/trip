module ItinerariesHelper

  def get_flights_schedules(flight)
    flight.schedules.each do |sch|
      sch
    end
  end

  def get_time_differnece(flight)
    flight = get_flights_schedules(flight)[0]
    seconds_diff = (flight.depart_time - flight.arrival_time).to_i.abs
    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600
    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60
    "#{hours.to_s.rjust(2, '0')}h#{minutes.to_s.rjust(2, '0')}m"
  end

  def getFlightCost(flight)
    cost = get_flights_schedules(flight)[0].base_cost.to_f
    days = (@date.to_date -  Time.now.to_date).to_i
    case days
      when 45..365 then
        cost
      when 30...45 then
        cost = cost * (130.00/100)
      when 15...30 then
        cost = cost * (160.00/100)
      when 0...15 then
        cost = cost * (190.00/100)
    end
    cost
  end

  def get_all_cities
    cities = []
    CS.states(:in).each do |key, value|
      CS.cities(key, :in).each do |city|  
        cities << city
      end  
    end 
    cities
  end

  def get_airline(airline_name)
    Airline.where(name: airline_name)
  end

  def filter_filghts
    if params[:airline_name].present? || params[:time_duration].to_i > 0 || params[:price_range].to_i > 0
    # sql = []
    #   if params[:airline_time].present?
    #     flights= []
    #     params[:airline_time].values.uniq.each do |element|
    #       flights << Flight.joins(:schedules).where('schedules.depart_time > ? AND schedules.depart_time < ?', element.first.to_time.strftime("%H:%M:%S"), element.last.to_time.strftime("%H:%M:%S") )
    #     end        
    #   end
      if params[:airline_name].present?
        @itineraries = Flight.joins(:schedules).where(source: @source ,destinition: @destinition ,schedules: {day: @day}, airline_id: get_airline(params[:airline_name])).includes(:schedules)
      end

      if params[:time_duration].to_i > 0
        time_diff(params[:time_duration])
      end

      if params[:price_range].to_i > 0
        selected_flight = []
        @itineraries = Flight.joins(:schedules).where(source: @source ,destinition: @destinition ,schedules: {day: @day}, base_cost: [0.. params[:price_range]]).includes(:schedules)
      end
    
      respond_to do |format|
        format.js
        format.html
      end
      else
        @itineraries = Flight.joins(:schedules).where(source: @source ,destinition: @destinition ,schedules: {day: @day}).includes(:schedules)
  end

  def time_diff(time_duration)
      selected_flight = []
      itineraries = Flight.joins(:schedules).where(source: @source ,destinition: @destinition ,schedules: {day: @day}).includes(:schedules)
      itineraries.each do |itinerary|
        flight = get_flights_schedules(itinerary)[0]
        seconds_diff = (flight.depart_time - flight.arrival_time).to_i.abs
        hours = seconds_diff / 3600
        if time_duration.to_i >= hours
          selected_flight << itinerary
        end
      end
      @itineraries = selected_flight.flatten
    end  

end
end



