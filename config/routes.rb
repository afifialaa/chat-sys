Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    post '/application', to: 'applications#create'
    delete '/application/:token', to: 'applications#delete'
    get '/application/:token', to: 'applications#show'
    put '/application/:token', to: 'applications#update'

    post '/application/:token/chat', to: 'chats#create'
    get '/application/:token/chat', to: 'chats#index'
    delete '/application/:token/chat/:number', to: 'chats#delete'
    get '/application/:token/chat/:token', to: 'chats#show'
    
end
