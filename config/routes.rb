Rails.application.routes.draw do

  namespace :admin do
    get 'orders/show'
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit]
  end

  namespace :admin do
    resources :genres, only: [:index, :edit]
  end

  namespace :admin do
    resources :items, only: [:new, :index, :show, :edit]
  end

  namespace :admin do
    get 'homes/top'
  end

  namespace :customer do
    resources :addresses, only: [:index, :edit]
  end

  namespace :customer do
    resources :orders, only: [:new, :thanx, :index, :show]
  end

  namespace :customer do
    resources :customers, only: [:show, :edit, :check]
  end

  namespace :customer do
    resources :items, only: [:index, :show]
  end

  namespace :customer do
    get 'homes/top'
    get 'homes/about'
  end

  # 顧客用
  # URL /customers/sign_in ~
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ~
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"

  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
