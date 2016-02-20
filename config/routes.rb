class SubdomainConstraint
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != 'www'
  end
end


Rails.application.routes.draw do
  
  constraints SubdomainConstraint do 
    root to: 'pages#show', as: :portfolio
    DynamicRouter.load
    get '/users/:id/setup', to: 'users#setup', as: :setup
    resources :analytics
    resources :calendars
    resources :events
    resources :users
  end

  root to: 'pages#index', as: :marketing

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#auth_fail'
  get '/sign_out', to: 'sessions#destroy', as: :sign_out

  get 'contact', to: 'events#new', as: 'contact'
  post 'contact', to: 'events#create'

end
