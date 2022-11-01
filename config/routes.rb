Rails.application.routes.draw do

  # ユーザー用
  # URL /customers/sign_in ~
  devise_for :customer, skip: [:passwords], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }

   # 管理者用
  # URL /admin/sign_in ~
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"

  }

 # 管理者用
  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_detas, only: [:update]
  end

  # ユーザー用
  namespace :customer do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update, :check, :withdrawl]
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all,:create]
    resources :orders, only: [:new, :thanx, :create, :index, :show]
    get 'orders/log' => 'orders#log', as: 'log'
    get 'orders/thanx' => 'orders#thanx', as: 'thanx'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
