json.extract! upload, :id, :title, :description, :file_type, :file_size, :url, :user_id, :created_at, :updated_at
json.url upload_url(upload, format: :json)
