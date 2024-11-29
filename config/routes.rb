Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    member do
      post 'like', to: 'posts#like'
      post 'unlike', to: 'posts#unlike'
    end
    resources :comments, only: :create   # เส้นทางสำหรับคอมเมนต์
  end

  root "posts#index"
end
