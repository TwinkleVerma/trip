module ApplicationHelper

  def get_airline_logo(flight)
    flight.airline.image.avatar_url
  end

end
