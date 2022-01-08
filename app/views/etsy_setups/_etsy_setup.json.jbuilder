json.extract! etsy_setup, :id, :api_key, :api_secret, :code, :token, :secret, :created_at, :updated_at
json.url etsy_setup_url(etsy_setup, format: :json)
