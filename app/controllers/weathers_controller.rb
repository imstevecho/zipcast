class WeathersController < ApplicationController
  def index
    @weather_data = {}
    query = params[:q]

    return unless query.present?

    result = WeatherService.new.fetch_weather(query)
    @forecast_data = result[:forecast_data]
    @is_from_cache = result[:is_from_cache]
  end
end
