Rails.application.routes.draw do

  root 'sessions#new'

# Resident

  # register new resident
  get 'sessions/new'
  get 'register', to: 'residents#new'
  post 'register', to: 'residents#create'

  # show all residents
  get 'residents/index'

  # edit resident info
  get 'residents/:floor/:unit/edit', to: 'residents#edit'
  patch 'residents/:floor/:unit/edit', to: 'residents#update'

  # delete resident entry
  delete 'residents/:floor/:unit', to: 'residents#destroy'


# Sessions

  # login
  get 'login' , to: 'sessions#new'
  post 'login', to: 'sessions#create'

  #logout
  delete 'logout', to: 'sessions#destroy'


# Twilio
  post 'twilio', to: 'twilio#create'


# Visitor Pass
  resources :visitor_passes, only: [:new, :create]

# Visitor Details
  resources :visitor_details, only: [:new, :create, :edit, :update]

end
