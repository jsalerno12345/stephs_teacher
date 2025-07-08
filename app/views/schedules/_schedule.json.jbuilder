json.extract! schedule, :id, :day_of_week, :start_time, :end_time, :activity, :created_at, :updated_at
json.url schedule_url(schedule, format: :json)
