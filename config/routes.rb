Rails.application.routes.draw do
  resources :work_time_patterns
  resources :time_records
  root 'time_records#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
