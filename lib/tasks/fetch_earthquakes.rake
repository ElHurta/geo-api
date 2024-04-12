namespace :fetch_earthquakes do
    desc "Fetch earthquake data from USGS"
    task run: :environment do
      response = HTTParty.get("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson")
      data = JSON.parse(response.body)
      
      fetched_count = 0
  
      data["features"].each do |feature|
        
        next if feature["properties"]["title"].blank? ||
                feature["properties"]["url"].blank? ||
                feature["properties"]["place"].blank? ||
                feature["properties"]["magType"].blank? ||
                feature["geometry"]["coordinates"].blank?
  
        magnitude = feature["properties"]["mag"]
        latitude = feature["geometry"]["coordinates"][1]
        longitude = feature["geometry"]["coordinates"][0]
  
        next if magnitude.nil? || magnitude < -1.0 || magnitude > 10.0
        next if latitude.nil? || latitude < -90.0 || latitude > 90.0
        next if longitude.nil? || longitude < -180.0 || longitude > 180.0
  
        Feature.find_or_create_by(usgs_id: feature["id"]) do |f|
          f.magnitude = magnitude
          f.type = feature["type"]
          f.place = feature["properties"]["place"]
          f.time = Time.at(feature["properties"]["time"] / 1000)
          f.url = feature["properties"]["url"]
          f.tsunami = feature["properties"]["tsunami"]
          f.mag_type = feature["properties"]["magType"]
          f.title = feature["properties"]["title"]
          f.longitude = longitude
          f.latitude = latitude
        end
  
        fetched_count += 1
      end
  
      puts "Fetched #{fetched_count} earthquakes"
    end
  end