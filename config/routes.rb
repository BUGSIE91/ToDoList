Rails.application.routes.draw do
  get 'checklists/new'

  post 'checklists/create'

  get 'index' => 'checklists/index'

  get 'checklists/edit'

  get 'checklists/delete'

  post 'checklists/update'
  
  delete 'checklists/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'signup' => 'users#new'
  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  get 'index' => 'checklists#index'

  root 'checklists#index'

end
