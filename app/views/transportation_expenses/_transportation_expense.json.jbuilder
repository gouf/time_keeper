json.extract! transportation_expense, :id, :destination, :route, :destination_from, :destination_to, :is_round_trip, :cost, :created_at, :updated_at
json.url transportation_expense_url(transportation_expense, format: :json)
