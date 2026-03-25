Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resource :business_profile, only: [:show, :update]

  resources :invoices, except: [:new, :edit] do
    member do
      get  :pdf
      post :regenerate_pdf
      post :send_receipt
    end
  end

  resources :clients do
    resource :rate, only: [:show, :update]
  end
  resources :projects do
    resource :rate, only: [:show, :update]
    resources :time_entries, only: [:index, :create, :update, :destroy]
  end
end
