require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url1 = "https://api.darksky.net/forecast/89b9dfee8ef5a7d350ea5e42a0cadd7c/#{@lat},#{@lng}"

    parsed_data = JSON.parse(open(url1).read)
    temperature = parsed_data["currently"]["temperature"]
    summaryc = parsed_data["currently"]["summary"]
    summarynsm = parsed_data["minutely"]["summary"]
    summarynsh = parsed_data["hourly"]["summary"]
    summarynsd = parsed_data["daily"]["summary"]

    @current_temperature = temperature

    @current_summary = summaryc

    @summary_of_next_sixty_minutes = summarynsm

    @summary_of_next_several_hours = summarynsh

    @summary_of_next_several_days = summarynsd

    render("forecast/coords_to_weather.html.erb")
  end
end
