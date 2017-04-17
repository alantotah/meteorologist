require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    user_address = @street_address.downcase.tr(" ", "+")
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{user_address}"

    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url1 = "https://api.darksky.net/forecast/89b9dfee8ef5a7d350ea5e42a0cadd7c/#{latitude},#{longitude}"

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

    render("meteorologist/street_to_weather.html.erb")
  end
end
