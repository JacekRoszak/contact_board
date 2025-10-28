Rails.application.routes.draw do
  devise_for :users
  resources :contacts, except: [:show, :edit]
  root 'contacts#index'
end
