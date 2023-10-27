class ForecastService
  include CacheKeyGenerator
  BASE_URL = 'https://api.openweathermap.org/data/2.5'.freeze
  CACHE_EXPIRATION = 30.minutes.freeze

  def initialize
    @options = {
      id: ENV['OPENWEATHER_API_ID'],
      appid: ENV['OPENWEATHER_API_KEY'],
      units: ENV['OPENWEATHER_UNITS']
    }
  end

  # Fetch weather forecast data based on latitude and longitude
  def with_lat_lon(lat, lon, skip_cache: false)
    key = cache_key('forecast', lat, lon)
    is_from_cache = Rails.cache.exist?(key)
    forecast_data = fetch_with_cache(key, lat, lon, skip_cache)

    {
      forecast_data: forecast_data,
      is_from_cache: is_from_cache
    }
  end

  private

  # Fetch API response and parse it
  def fetch(path, query = {})
    full_query = query.merge(@options)
    url = "#{BASE_URL}#{path}"
    response = HTTParty.get(url, { query: full_query })

    JSON.parse(response.body).tap do |_parsed_response|
      raise 'API Error' unless response.success?
    end
  end

  # Fetch forecast data either from cache or API
  def fetch_with_cache(key, lat, lon, skip_cache)
    CachingService.fetch(key, expires_in: CACHE_EXPIRATION, skip_cache: skip_cache) do
      Rails.logger.info "Fetching forecast for #{lat}, #{lon}"
      query = { lat: lat, lon: lon }
      parsed_response = fetch('/forecast', query)

      parse_forecast(parsed_response['list'])
    end
  end

  # Parse the forecast data from API response
  def parse_forecast(list)
    list.map do |forecast|
      {
        date: forecast['dt'],
        temp: forecast['main']['temp'],
        temp_min: forecast['main']['temp_min'],
        temp_max: forecast['main']['temp_max']
      }
    end
  end
end
