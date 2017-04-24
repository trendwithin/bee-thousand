Rails.application.routes.draw do
  root 'pages#welcome'
  get 'pages/registered'
  get 'pages/about'
  get 'pages/contact'
  get 'pages/testimonial'

  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
