Rails.application.routes.draw do

    namespace :api do
        namespace :v1 do
            post '/application', to: 'applications#create'
            delete '/application/:token', to: 'applications#delete'
            get '/application/:token', to: 'applications#show'
            put '/application/:token', to: 'applications#update'

            post '/application/:token/chat', to: 'chats#create'
            get '/application/:token/chat', to: 'chats#index'
            delete '/application/:token/chat/:number', to: 'chats#delete'
            get '/application/:token/chat/:number', to: 'chats#show'

            post '/application/:token/chat/:number/message', to: 'messages#create'
            delete '/application/:token/chat/:chat_number/message/:message_number', to: 'messages#delete'
            put '/application/:token/chat/:chat_number/message/:message_number', to: 'messages#update'
            get '/application/:token/chat/:chat_number/message/:message_number', to: 'messages#show'

            get '/application/:token/chat/:chat_number/message/search/:query', to: 'messages#partial_search'
        end
    end
end