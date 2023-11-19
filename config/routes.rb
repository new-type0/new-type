Rails.application.routes.draw do

  namespace :admin do
    resources :oders, only: [:update, :show]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    root to: 'homes#top'
  end

  namespace :public do
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :arders, only: [:index, :create, :show, :new]
    post 'orders/confirm', to: 'orders#confirm'
    get 'orders/thanks', to: 'orders#thanks'
    resources :cart_items, only: [:index, :update, :create, :destroy]
    delete 'cart_items/destroy_all', to: 'cart_items#destroy_all' #deketeメソッドちゃんと機能してる？
    resources :customers, only: [:edit, :update, :show]
      patch 'customers/unsubscribe/:id', to: 'customers#unsubscribe', as: 'customers/unsubscribe'
      get 'customers/confirm', to: 'customers#confirm'
    resources :items, only: [:index, :show] 
    end
    
    root to: 'homes#top'
    get 'homes/about' => 'homes#about', as: '/about'
    get 'genre/search' => 'searches#genre_search'


devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
