module FlightsHelper

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
end
