Rails.application.routes.draw do
  root 'urls#new'

  get "up" => "rails/health#show", as: :rails_health_check
  get '/:short_url', to: 'urls#redirect'

  resources :urls, only: [:new, :create, :show]

end
