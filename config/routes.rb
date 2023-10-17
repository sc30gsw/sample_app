Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contact'
  get "up" => "rails/health#show", as: :rails_health_check

  root "application#hello"
end
