Rails.application.routes.draw do
  get 'timelines/index'

  root 'pages#welcome'
  get 'pages/registered'
  get 'pages/about'
  get 'pages/contact'
  get 'pages/testimonial'
  resources :microposts, only: [:create, :destroy] do
    resource :like, module: :microposts
  end
  resources :alerts

  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
