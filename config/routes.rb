Rails.application.routes.draw do
  # 3.4.4演習No.2_コメントアウト解除
  root 'static_pages#home'
  # 5.3.2演習No.1
  # get  '/help',    to: 'static_pages#help', as: 'helf'
  # 5.3.2演習No.3
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
