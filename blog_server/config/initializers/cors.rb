Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins "*" # or 'http://localhost:3001' for stricter control
      resource "*", headers: :any, methods: [ :get, :post, :put, :patch, :delete, :options, :head, :create ]
    end
  end
