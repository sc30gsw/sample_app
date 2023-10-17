Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  get "up" => "rails/health#show", as: :rails_health_check

  root "application#hello"
end
