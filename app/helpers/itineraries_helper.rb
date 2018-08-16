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

  def time_diff(time_duration)
      selected_flight = []
      itineraries = Flight.joins(:schedules).where(source: @source ,destinition: @destinition ,schedules: {day: @day}).includes(:schedules)
      itineraries.each do |itinerary|
        flight = get_flights_schedules(itinerary)[0]
        seconds_diff = (flight.depart_time - flight.arrival_time).to_i.abs
        hours = seconds_diff / 3600
        seconds_diff -= hours * 3600
        minutes = seconds_diff / 60
        if time_duration.to_f >= (hours.to_s+"."+minutes.to_s).to_f
          selected_flight << itinerary
        end
      end
      selected_flight.flatten
    end  


  def filter_filghts
    sql = []
    sql << "source = '#{@source}'"
    sql << "destinition = '#{@destinition}'"
    sql << "schedules.day = '#{@day}'"
    if params[:airline_name].present?
        params[:airline_name] = params[:airline_name].collect{|airline_name| "'" + airline_name + "'"}
        sql << "airlines.name in (#{params[:airline_name].join(',')})"
    end
    if params[:time_duration].present?
      sql << "(schedules.arrival_time - schedules.depart_time <= '#{(params[:time_duration].to_i*3600).to_s}')"
    end

    # if params[:airline_time].present?
    #   time_query = []
    #   date = Date.new(2000,01,01)
    #   params[:airline_time].each do |key , value|
    #     startt = params[:airline_time]["#{key}"][0].to_time
    #     endt = params[:airline_time]["#{key}"][0].to_time
    #     start_time = DateTime.new(date.year, date.month, date.day, startt.strftime("%H").to_i, startt.strftime("%M").to_i, startt.strftime("%S").to_i)
    #     end_time = DateTime.new(date.year, date.month, date.day, endt.strftime("%H").to_i, endt.strftime("%M").to_i, endt.strftime("%S").to_i)
    #     time_query << '(schedules.depart_time >= ? AND schedules.depart_time <= ? )'
    #   end
    #   sql << time_query.join(" OR ")
    # end
    sql_query = sql.join(" AND ")
    Flight.joins(:schedules).joins(:airline).where(sql_query).includes(:schedules)


    # if params[:airline_time].present?
    #   @itineraries = Flight.joins(:schedules).joins(:airline).where(a, params[]).includes(:schedules)
    # else
    #   @itineraries = Flight.joins(:schedules).joins(:airline).where(sql_query).includes(:schedules)
    # end
  end

  def get_flight_detail(flight)
    Flight.find(flight)
  end

  def get_schedule_detail(schedule)
    Schedule.find(schedule)
  end
  def get_schedule_flight_detail(schedule)
    Schedule.find(schedule).flight
  end

  def get_schedule_flight_image(schedule)
    schedule = Schedule.find(schedule)
    get_airline_logo(schedule.flight)
  end

  def get_differnce_between_depart_time_and_arrival_time(schedule)
    schedule = get_schedule_detail(schedule)
    seconds_diff = (schedule.depart_time - schedule.arrival_time).to_i.abs
    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600
    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60
    "#{hours.to_s.rjust(2, '0')}h#{minutes.to_s.rjust(2, '0')}m"
  end

  def get_airline_name(flight)
    flight = Flight.find(flight)
    flight.airline.name
  end
end



