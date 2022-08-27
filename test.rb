require "http"
system "clear"
puts "Welcome to the Simple Weather Conditions App."
puts "This checks the wind conditions at any location in the US."
puts "To start, enter the coordinates for the location you want to check."
puts "You can find the coordinates on Google Maps. Type 'help' for more instructions."

# Instructions for Google Maps - need to be moved to the correct location
# puts "Right click any location within the US. Click on the coordinates at the top of the menu that pops up. This copies them to you clipboard."

# Instructions for Apple Maps - need to be moved to the correct location
# puts "Right click any location within the US. Click 'Drop Pin' at the top of the menu."
# puts "Under 'Coordinates', select and copy the coordinates listed."

coordinates_s = gets.chomp # Getting coordinates from Google maps
coordinates_s = coordinates_s.gsub(/\s+/, "") # Removing space from string
coordinates_a = coordinates_s.split(",") # Splitting coordinates into an array
coordinates_a[0] = coordinates_a[0].to_f.round(4) # Coverting string to a float and rounding to 4 decimal places
coordinates_a[1] = coordinates_a[1].to_f.round(4) # Coverting string to a float and rounding to 4 decimal places
# p coordinates_a

# First API Site. Used to get next URL, City, and State
response = HTTP.get("https://api.weather.gov/points/#{coordinates_a[0]},#{coordinates_a[1]}")
city = response.parse(:json)["properties"]["relativeLocation"]["properties"]["city"]
state = response.parse(:json)["properties"]["relativeLocation"]["properties"]["state"]

# Second API Site. Used to get weather conditions at the specified coordinates
new_response = HTTP.get(response.parse(:json)["properties"]["forecast"])

# Current conditions
current_wind_speed = new_response.parse(:json)["properties"]["periods"][0]["windSpeed"]
current_time = new_response.parse(:json)["properties"]["periods"][0]["name"].downcase
current_wind_direction = new_response.parse(:json)["properties"]["periods"][0]["windDirection"]

# Future conditions
future_wind_speed = new_response.parse(:json)["properties"]["periods"][1]["windSpeed"]
future_time = new_response.parse(:json)["properties"]["periods"][1]["name"].downcase
future_wind_direction = new_response.parse(:json)["properties"]["periods"][1]["windDirection"]

puts ""
puts "The wind speed in #{city}, #{state} #{current_time} is currently #{current_wind_speed} headed #{current_wind_direction}."
puts ""
puts "The wind speed #{future_time} should be #{future_wind_speed} headed #{future_wind_direction}."
