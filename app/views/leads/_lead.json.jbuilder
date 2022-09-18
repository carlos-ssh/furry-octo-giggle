json.extract! lead, :id, :first_name, :last_name, :email, :phone, :note, :created_at, :updated_at
json.url lead_url(lead, format: :json)
