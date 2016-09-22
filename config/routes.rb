Rails.application.routes.draw do

  root to: 'landing#index'

  resources :lists, except: [:show] do
    resources :tasks, except: [:show]
  end

  patch :completed, to: 'tasks#completed'

end
