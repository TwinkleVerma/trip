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
    days = (@searchDate.to_date -  Time.now.to_date).to_i
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
end