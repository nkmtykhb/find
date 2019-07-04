Rails.application.routes.draw do
  get '' => 'home#top'
  get 'about' => 'home#about'
  get 'signup' => 'home#signup'

  get 'posts/index' => 'posts#index'
  get 'posts/question' => 'posts#qs_new'
  post 'posts/qs_create' => 'posts#qs_create'
  post 'posts/:id/as_create' => 'posts#as_create'
  get 'posts/:id' => 'posts#show'


  get 'users/student' => 'users#student'
  get 'users/teacher' => 'users#teacher'

  get 'users/:id' => "users#show"
  get 'st_signup' => 'users#st_new'
  get 'te_signup' => 'users#te_new'
  post 'users/st_create' => 'users#st_create'
  post 'users/te_create' => 'users#te_create'
  get 'users/:id/st_edit' => 'users#st_edit'
  get 'users/:id/te_edit' => 'users#te_edit'
  post 'users/:id/st_update' => 'users#st_update'
  post 'users/:id/te_update' => 'users#te_update'


  get 'login' => 'users#login_form'
  post 'login' => 'users#login'

  post 'logout' => 'users#logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
