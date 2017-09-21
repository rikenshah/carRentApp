json.extract! reservation, :id, :user_id, :car_id, :check_out, :return, :checked_out, :returned, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
