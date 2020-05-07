Rails.application.routes.draw do

  get 'register', to: 'residents#new'
  post 'register', to: 'residents#create'

  get 'residents/index'

  get 'residents/:floor/:unit/edit', to: 'residents#edit'
  patch 'residents/:floor/:unit/edit', to: 'residents#update'

  delete 'residents/:floor/:unit', to: 'residents#destroy'

end
