# frozen_string_literal: true

# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      root GET    /                                                                                        static_pages#home
#                      home GET    /home(.:format)                                                                          static_pages#home
#                      help GET    /help(.:format)                                                                          static_pages#help
#                     about GET    /about(.:format)                                                                         static_pages#about
#                   contact GET    /contact(.:format)                                                                       static_pages#contact
#                    signup GET    /signup(.:format)                                                                        users#new
#                microposts GET    /microposts(.:format)                                                                    microposts#index
#                           POST   /microposts(.:format)                                                                    microposts#create
#             new_micropost GET    /microposts/new(.:format)                                                                microposts#new
#            edit_micropost GET    /microposts/:id/edit(.:format)                                                           microposts#edit
#                 micropost GET    /microposts/:id(.:format)                                                                microposts#show
#                           PATCH  /microposts/:id(.:format)                                                                microposts#update
#                           PUT    /microposts/:id(.:format)                                                                microposts#update
#                           DELETE /microposts/:id(.:format)                                                                microposts#destroy
#                     users GET    /users(.:format)                                                                         users#index
#                           POST   /users(.:format)                                                                         users#create
#                  new_user GET    /users/new(.:format)                                                                     users#new
#                 edit_user GET    /users/:id/edit(.:format)                                                                users#edit
#                      user GET    /users/:id(.:format)                                                                     users#show
#                           PATCH  /users/:id(.:format)                                                                     users#update
#                           PUT    /users/:id(.:format)                                                                     users#update
#                           DELETE /users/:id(.:format)                                                                     users#destroy
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  root 'static_pages#home'

  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'

  resources :microposts
  resources :users
end
