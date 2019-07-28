# frozen_string_literal: true

# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#          new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#              user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#      destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#         new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#        edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#             user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                           PUT    /users/password(.:format)                                                                devise/passwords#update
#                           POST   /users/password(.:format)                                                                devise/passwords#create
#  cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#     new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#    edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#         user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                           PUT    /users(.:format)                                                                         devise/registrations#update
#                           DELETE /users(.:format)                                                                         devise/registrations#destroy
#                           POST   /users(.:format)                                                                         devise/registrations#create
#     new_user_confirmation GET    /users/confirmation/new(.:format)                                                        devise/confirmations#new
#         user_confirmation GET    /users/confirmation(.:format)                                                            devise/confirmations#show
#                           POST   /users/confirmation(.:format)                                                            devise/confirmations#create
#           new_user_unlock GET    /users/unlock/new(.:format)                                                              devise/unlocks#new
#               user_unlock GET    /users/unlock(.:format)                                                                  devise/unlocks#show
#                           POST   /users/unlock(.:format)                                                                  devise/unlocks#create
#                      root GET    /                                                                                        static_pages#home
#                      home GET    /home(.:format)                                                                          static_pages#home
#                      help GET    /help(.:format)                                                                          static_pages#help
#                     about GET    /about(.:format)                                                                         static_pages#about
#                   contact GET    /contact(.:format)                                                                       static_pages#contact
#                microposts GET    /microposts(.:format)                                                                    microposts#index
#                           POST   /microposts(.:format)                                                                    microposts#create
#                 micropost DELETE /microposts/:id(.:format)                                                                microposts#destroy
#            following_user GET    /users/:id/following(.:format)                                                           users#following
#            followers_user GET    /users/:id/followers(.:format)                                                           users#followers
#                     users GET    /users(.:format)                                                                         users#index
#                      user GET    /users/:id(.:format)                                                                     users#show
#                           DELETE /users/:id(.:format)                                                                     users#destroy
#             relationships GET    /relationships(.:format)                                                                 relationships#index
#                           POST   /relationships(.:format)                                                                 relationships#create
#          new_relationship GET    /relationships/new(.:format)                                                             relationships#new
#              relationship GET    /relationships/:id(.:format)                                                             relationships#show
#                           DELETE /relationships/:id(.:format)                                                             relationships#destroy
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'

  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  resources :microposts, only: %i[index create destroy]
  resources :users, only: %i[index show destroy] do
    member do
      get :following
      get :followers
    end
  end
  resources :relationships, except: %i[edit update]
end
