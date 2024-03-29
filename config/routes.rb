Post::Application.routes.draw do
  

  get "announcements/index"
  resources :announcements do
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

  get "article_posts/index"
  resources :article_posts do
    collection do
      get 'logout'
      get 'search'
      post 'comment'
      get 'delete_comment'
      post 'update_comment'
    end
  end

  get "users/index"
  resources :users do
    collection do
      get 'login'
      get 'register'
      get 'logout'
      get 'userprofile'
      post 'new_user'
      post 'validate'
      post 'update_profile_info'


    end
  end
  
root 'article_posts#index'




  


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
