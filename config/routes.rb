Rails.application.routes.draw do
  resources :settings
  resources :extramular_subjects
  resources :works
  resources :name_works
  get 'subjects/index'
  resources :subjects

  devise_for :users
  resources :users, :only => [:show, :index]

  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  match '/user/make_admin',   to: 'users#make_admin',   via: 'get', :as => :users_make_admin
  match '/user/revoke_admin',   to: 'users#revoke_admin',   via: 'get', :as => :users_revoke_admin

  post '/insert_to_bd_extramular', to: 'extramular_subjects#insert_to_bd_extramular', as: :insert_to_bd_extramular
  post '/insert_to_bd', to: 'settings#insert_to_bd', as: :insert_to_bd
  post '/create_excel', to: 'subjects#create_excel', as: :create_excel
  post '/insert_user_id', to: 'subjects#insert_user_id', as: :insert_user_id
  post '/change_user_id', to: 'subjects#change_user_id', as: :change_user_id
  post '/change_ext_user_id', to: 'extramular_subjects#change_ext_user_id', as: :change_ext_user_id
  post '/insert_extramural_user_id', to: 'extramular_subjects#insert_extramural_user_id', as: :insert_extramural_user_id
  post '/destroy_all_subjects', to: 'settings#destroy_all_subjects', as: :destroy_all_subjects
  post '/destroy_all_extramular_subjects', to: 'extramular_subjects#destroy_all_extramular_subjects', as: :destroy_all_extramular_subjects
  post '/destroy_all_output_files', to: 'users#destroy_all_output_files', as: :destroy_all_output_files
  post '/save_input_file', to: 'settings#save_input_file', as: :save_input_file
  post '/add_educational_and_methodical_work', to: 'works#add_educational_and_methodical_work', as: :add_educational_and_methodical_work
  post '/add_educational_work', to: 'works#add_educational_work', as: :add_educational_work
  post '/add_research_work', to: 'works#add_research_work', as: :add_research_work
  post '/add_organizational_and_methodical_work', to: 'works#add_organizational_and_methodical_work', as: :add_organizational_and_methodical_work
  post '/remove_subject', to: 'subjects#remove_subject', as: :remove_subject
  post '/remove_extramular_subject', to: 'extramular_subjects#remove_extramular_subject', as: :remove_extramular_subject

  root to: 'main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
