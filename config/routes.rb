CnpWeb::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => 'users/registrations', :sessions => 'users/sessions'}

  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
  end

  devise_for :student, :controllers => {:registrations => 'student/registrations', :sessions => 'student/sessions'}

  devise_scope :student do
    get 'student/sign_out', to: 'student/sessions#destroy', as: :destroy_admin_session , via:Devise.mappings[:student].sign_out_via
  end


  devise_for :admin, :controllers => {:registrations => 'admin/registrations', :sessions => 'admin/sessions'}

  devise_scope :admin do
    get 'admin/sign_out', to: 'admin/sessions#destroy', as: :destroy_admin_session , via:Devise.mappings[:admin].sign_out_via
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  match '/forums', to: 'forum#index', via: [:get]

  match '/my_profile', to: 'profile#my_profile', via: [:get, :post]

  match 'messages', to: 'profile#messages'
  #match 'create_forum'

 # get 'forum/:forum', to: 'forum#show', as: :forum

  resources :home

  resources :forum do
    resources :comments
  end


  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
