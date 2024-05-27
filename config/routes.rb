Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/profile', to: 'users#edit'
  patch '/profile', to: 'users#update'
  get '/profile/change_password', to: 'password#edit'
  patch '/profile/change_password', to: 'password#update'
  get '/password/reset', to: 'password_resets#new'
  post '/password/reset', to: 'password_resets#create'
  get '/password/reset/edit', to: 'password_resets#edit'
  patch '/password/reset/edit', to: 'password_resets#update'

  namespace :teacher do
    root "home#index"
    resources :courses do
      resources :sections, except: [:index, :show] do
        resources :lectures, except: [:index] do
          resources :contents, except: [:index, :show]
        end
        resources :exams do
          resources :questions, except: [:index, :show]
        end
      end
      resources :inscriptions, only: [:index, :destroy, :update]
      resources :exam_answers, only: [:index, :show, :update] do
        resources :question_answers do
          get 'download', on: :member
        end
      end
      resources :conversations, only: [:show, :update, :index]
      resources :students, only: [:index, :show]
      patch 'order_sections', on: :member
      patch 'order_lectures', on: :member
      patch 'order_exams', on: :member
      get 'reviews', to: 'review#index'
      patch 'publish', on: :member
    end
    resources :inscriptions, only: [:index, :destroy, :update]
    resources :exam_answers, only: [:index, :show, :update] do
      resources :question_answers do
        get 'download', on: :member
      end
    end
    get '/profile', to: 'users#edit'
    patch '/profile', to: 'users#update'
    get '/profile/change_password', to: 'password#edit'
    patch '/profile/change_password', to: 'password#update'
    resources :students, only: [:index, :show]
    resources :conversations, only: [:show, :update, :index]
  end

  namespace :student do
    root "home#index"
    resources :courses, only: [:show, :index, :update, :edit, :destroy] do
      resources :lectures, except: [:index]
      resources :exams, only: [:show, :index] do
        get '/questions/:number', to: 'questions#edit', as: 'question'
        patch '/questions/:number', to: 'questions#update'
        get '/questions', to: 'questions#index'
      end
      post '/exams/:id', to: 'exams#create'
      resources :conversations, only: [:create, :update]
      get '/chat', to: 'conversations#show'
    end
    resources :conversations, only: [:show, :update, :index]
  end

  resources :courses, only: [:index, :show] do
    resources :lectures, only: :show
    resources :exams, only:[:index, :show]
    resources :payments, only: :new
    get '/payments/success', to: 'payments#success'
    resources :inscriptions, only: :new
  end

  resources :teachers, only: [:index, :show]

  root "home#index"

end
