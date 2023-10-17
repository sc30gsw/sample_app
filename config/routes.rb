Rails.application.routes.draw do
  # 3.4.4演習No.2_コメントアウト
  # root "static_pages#home"
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contact'
  get "up" => "rails/health#show", as: :rails_health_check
end
