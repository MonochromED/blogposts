Restaurant::Application.routes.draw do
  

  get "news_posts/index"
  resources :news do
    collection do
      get 'logout'
    end
  end

  get "avatars/index"
  resources :avatars do
    collection do
      get 'logout'
    end
  end

  get "comments/index"
  resources :comments do
    collection do
      get 'logout'
    end
  end

  get "restaurant/index"
  resources :restaurant do
    collection do
      get 'logout'
    end
  end

  get "reviews/index"
  resources :reviews do
    collection do
      get 'logout'
      get 'search'
      post 'comment'
      get 'editcomment'
      get 'deletecomment'
      post 'updatecomment'
    end
  end

  get "users/index"
  resources :users do
    collection do
      get 'login'
      get 'register'
      get 'logout'
      get 'userprofile'
      post 'newuser'
      post 'validate'
      post 'updateProfileInfo'


    end
  end
  
root 'reviews#index'




  


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
