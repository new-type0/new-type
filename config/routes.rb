Rails.application.routes.draw do
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  root to: 'public/homes#top'

  namespace :admin do
    resources :orders, only: [:index, :update, :show]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
     resources :order_details, only: [:update]
    get '/' => 'orders#index'
  end

  namespace :public do
     get 'customers/confirm', to: 'customers#confirm'
     patch 'customers/unsubscribe', to: 'customers#unsubscribe', as: 'customers/unsubscribe'
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    get 'orders/thanks', to: 'orders#thanks'
    resources :orders, only: [:index, :create, :show, :new]
    post 'orders/confirm', to: 'orders#confirm'
    resources :cart_items, only: [:index, :update, :create]
      delete 'cart_items/destroy_all', to: 'cart_items#destroy_all'
      delete 'cart_items/destroy/:id', to: 'cart_items#destroy'
    resources :customers, only: [:edit, :update]
      get 'customers/my_page' => 'customers#show'
    resources :items, only: [:index, :show]
    get 'homes/about' => 'homes#about', as: '/about'
  end

devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations,:passwords], controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
