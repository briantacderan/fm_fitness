Rails.application.routes.draw do
  devise_for :users
  resources :pages
  root 'pages#home'
  get 'about' => 'pages#about'
  get 'programs' => 'pages#programs'
  get 'testimonies' => 'pages#testimonies'
  resources :profile
  get 'overview' => 'profile#overview'
  get 'schedule' => 'profile#schedule'
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