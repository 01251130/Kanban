Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#index'


  resources :list, only: %i(new create edit update destroy) do
    # 以下は、右記と同義。  resources :card, only: %i(new create show edit update destroy)
    resources :card, except: %i(index)
 end
  resources :user, only: %i(edit update)

end