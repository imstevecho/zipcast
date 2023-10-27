class WeatherService
  ZIP_PATTERN = /^\d{5}$/  # Defining the ZIP pattern as a constant

  def initialize
    @geocode_service = GeocodeService.new
    @forecast_service = ForecastService.new
  end

  # Fetch weather data by either ZIP code or address
  def fetch_weather(address_or_zip)
    coords = fetch_coords(address_or_zip)

    return "Can't find coordinates for #{address_or_zip}" unless coords

    @forecast_service.with_lat_lon(coords[:lat], coords[:lon])
  end

  private

  # Determine if the input is a ZIP code
  def looks_like_zip?(str)
    ZIP_PATTERN.match?(str)
  end

  # Fetch coordinates based on whether the input is a ZIP code or address
  def fetch_coords(address_or_zip)
    if looks_like_zip?(address_or_zip)
      @geocode_service.coords_by_zipcode(address_or_zip, 'US')
    else
      @geocode_service.coords_by_address(address_or_zip)
    end
  end
end
