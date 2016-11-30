Rails.application.routes.draw do
  resources :transportation_expenses
  resources :transportation_expense_patterns
  resources :work_time_patterns
  resources :work_time_records
  root 'work_time_records#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
