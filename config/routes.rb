Rails.application.routes.draw do
  resources :settings
  resources :extramular_subjects
  resources :works
  resources :name_works
  get 'subjects/index'
  resources :subjects#, except: ['index','new']
  #   resources :user do
  #     get :insert_to_bd
  #   end
  # end
  # get 'insert_to_bd', to: 'subjects/insert_to_bd'
  devise_for :users

  post '/insert_to_bd_extramular', to: 'extramular_subjects#insert_to_bd_extramular', as: :insert_to_bd_extramular
  post '/insert_to_bd', to: 'subjects#insert_to_bd', as: :insert_to_bd
  post '/create_excel', to: 'subjects#create_excel', as: :create_excel
  post '/insert_user_id', to: 'subjects#insert_user_id', as: :insert_user_id
  post '/destroy_all_subjects', to: 'subjects#destroy_all_subjects', as: :destroy_all_subjects
  post '/destroy_all_extramular_subjects', to: 'extramular_subjects#destroy_all_extramular_subjects', as: :destroy_all_extramular_subjects
  post '/destroy_all_output_files', to: 'subjects#destroy_all_output_files', as: :destroy_all_output_files
  post '/save_input_file', to: 'subjects#save_input_file', as: :save_input_file
  post '/add_educational_and_methodical_work', to: 'works#add_educational_and_methodical_work', as: :add_educational_and_methodical_work
  post '/add_educational_work', to: 'works#add_educational_work', as: :add_educational_work
  post '/add_research_work', to: 'works#add_research_work', as: :add_research_work
  post '/add_organizational_and_methodical_work', to: 'works#add_organizational_and_methodical_work', as: :add_organizational_and_methodical_work



  root to: 'subjects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
