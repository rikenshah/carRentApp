json.extract! car, :id, :status, :model, :manufacturer, :style, :rent, :location, :licence_plate, :created_at, :updated_at
json.url car_url(car, format: :json)
