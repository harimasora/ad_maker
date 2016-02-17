Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'production_orders#index'

  # Concerns must be declared before
  # http://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper/Concerns.html
  concern :attachable do
    resources :attachments, only: :create
  end

  resources :production_orders, concerns: [:attachable]
  put 'production_orders/:id/approve' => 'production_orders#approve'
  put 'production_orders/:id/cancel' => 'production_orders#cancel'
  put 'production_orders/:id/check_design' => 'production_orders#check_design'
  put 'production_orders/:id/reject' => 'production_orders#reject'

  resources :business_units, only: [:index]
  resources :users, only: [:index]

  namespace :api do
    resources :federation_units, only: [:index]
    resources :cities, only: [:index]
    resources :groups, only: [:index]
    resources :subgroups, only: [:index]
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
