CatarseStripe::Engine.routes.draw do
  resources :stripe, only: [], path: 'payment/stripe' do
    member do
      get  :review
      post :charge
      post :pay
    end

    collection do
      get :auth
      get :callback
    end
  end
end
