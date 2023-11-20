import csv
import folium
from pyproj import Proj
import easygui

# Initialize the map with OpenStreetMap as the basemap
m = folium.Map(location=[0, 0], zoom_start=12, tiles='https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', attr='OpenStreetMap')

# Create a UTM projection for zone 10
p = Proj(proj='utm', zone=10, ellps='WGS84')

# Prompt the user to select a CSV file
file_path = easygui.fileopenbox(filetypes=['*.csv'])

# Read in the selected CSV file
with open(file_path) as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    next(csv_reader) # Skip the header row
    for row in csv_reader:
        if all(x == '' for x in row):
            continue # Skip empty rows
        try:
            # Extract the UTM coordinates from the appropriate columns of the CSV row
            easting = float(row[4])
            northing = float(row[5])

            # Convert the UTM coordinates to lat/lon
            lon, lat = p(easting, northing, inverse=True)

            # Add a marker to the map for the current location
            folium.Marker(location=[lat, lon], popup='Location').add_to(m)
        except (ValueError, IndexError):
            # Handle errors where the row does not have enough values
            print(f"Skipping row {csv_reader.line_num}: {row}")

# Save the map as an HTML file
m.save('map.html')
