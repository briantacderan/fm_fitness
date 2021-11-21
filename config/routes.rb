Rails.application.routes.draw do
  resources :lesson_payments
  resources :bookings
  resources :schedules
  resources :clients
  resources :trainers
  resources :lessons
  resources :account
  devise_for :users
  resources :pages
  root 'pages#home'
  get 'about' => 'pages#about'
  get 'programs' => 'pages#programs'
  resources :profile
  get 'overview' => 'profile#show'
  namespace :stripe do
    resources :checkouts
    post 'webhook' => 'checkouts#webhook'
    post 'add' => 'checkouts#new'
    get 'cart' => 'checkouts#show'
    get 'finalize' => 'checkouts#create'
    get 'thanks' => 'checkouts#thanks'
    get 'restart' => 'checkouts#destroy'
  end
  resources :subscriptions
end