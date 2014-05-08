Rails.application.routes.draw do
  resources :lists do
    collection do
      get :generate
      post :sort
    end
  end
end
