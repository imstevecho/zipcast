# Technical Summary: Weather Forecast Application

## Introduction

The Weather Forecast application is a Ruby on Rails-based web service designed to provide weather forecast data to users based on an input address or ZIP code. The application fetches weather data including current temperature, high, and low, with the additional feature of providing extended forecasts. All the fetched data is cached for 30 minutes to improve performance and user experience.

## Disclaimer

I was not able to find a free API that returns daily temperature high/low. The data used in this application comes from the OpenWeatherMap API, which provides a 5-day weather forecast. Please consider this when using the application.

## Demo Application
https://zipcast-7a6162b14230.herokuapp.com

## Architecture & Libraries

- Ruby on Rails for the backend
- RSpec for testing

## Main Components

1. **Geocode Service**: Converts input address or ZIP code to coordinates (latitude and longitude).
2. **Forecast Service**: Fetches forecast data for given coordinates.
3. **Weather Service**: Orchestrates Geocode and Forecast services and manages caching.

## Functionality

- **Address Input**: The application accepts an address or ZIP code as an input through a web form.
- **Data Retrieval**: Utilizes a Geocode service to convert the address to latitude and longitude, and a Forecast service to fetch the weather data.
- **Data Display**: Presents the fetched forecast, which includes current temperature, and optionally, the high/low temperatures and extended forecasts.

## Caching

- **Duration**: All weather data is cached for 30 minutes.
- **Scope**: Caching is done on a per-ZIP code basis.
- **Cache Indication**: The application displays an indicator to notify users when data is retrieved from the cache.

## Testing

- **RSpec**: Unit tests are provided for main components and functionalities, such as data fetching, caching, and error handling.

## Future Enhancements

- Addition of real-time alerts and notifications.
- Expansion to include more comprehensive weather data like humidity, wind speed, etc.
