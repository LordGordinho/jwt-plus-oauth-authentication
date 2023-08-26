Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  namespace 'api' do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      sessions: 'api/auth/sessions'
    }

    resources :tests
  end
end
