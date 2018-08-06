module ItinerariesHelper

  def get_flights_schedule(flight_id)
    Schedule.find_by_flight_id(flight_id)
  end

  def get_time_differnece(flight_id)
    flight = get_flights_schedule(flight_id)
    time_diff = ((Schedule.find_by_flight_id(1).arrival_time - Schedule.find_by_flight_id(1).depart_time)/3600)
    time = time_diff.to_s
    time["."] = "h"
    time+"m"
  end

  def getFlightCost(flight_id)
    # cost = get_flights_schedule(flight_id).base_cost
    # days = (@searchDate.to_date -  Time.now.to_date).to_i
    # if days>=30
    #   cost = cost+(cost*30)
    # end
  end

end
