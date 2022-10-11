Rails.application.routes.draw do
  resources :subscribers

# Create a new subscriber from client JSON POST request
  post '/api/subscribers', to: 'subscribers#create', defaults: { format: 'json' }

# i have this error displayed on console: POST http://127.0.0.1:3000/subscribers 422 (Unprocessable Entity)
# this happens when the server Sends a response to the client, but the client is not able to understand it.
# i have tried to add this line to the controller:

#   skip_before_action :verify_authenticity_token, if: :json_request?


  get 'pages/home'
  get 'pages/dashboard'
  devise_for :users
  resources :users
  resources :leads do
    collection { post :import }
  end
  
  root "pages#home"
end
