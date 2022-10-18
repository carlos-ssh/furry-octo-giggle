# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://rentaspostal.vercel.app/'
    resource 'https://rentaspostal.vercel.app/', headers: :any, methods: [:get, :post, :patch, :put]
  end
end