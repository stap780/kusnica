json.extract! product, :id, :sku, :title, :desc, :cat, :oldprice, :price, :quantity, :image, :url, :parametr, :ins_id, :ins_var_id, :ebay_id, :etsy_id, :created_at, :updated_at
json.url product_url(product, format: :json)
