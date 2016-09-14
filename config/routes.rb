Rails.application.routes.draw do

  resources :lists, except: [:show] do
    resources :tasks, except: [:show]
  end

  root to: 'landing#index'

end
