Rails.application.routes.draw do

    namespace :api do
        namespace :v1 do
            post '/application', to: 'applications#create'
            delete '/application/:token', to: 'applications#delete'
            get '/application/:token', to: 'applications#show'
            put '/application/:token', to: 'applications#update'

            get '/application/:token/chats', to: 'chats#index'
            post '/application/:token/chat', to: 'chats#create'
            delete '/application/:token/chat/:chat_number', to: 'chats#delete'
            get '/application/:token/chat/:chat_number', to: 'chats#show'

            post '/application/:token/chat/:chat_number/message', to: 'messages#create'
            get '/application/:token/chat/:chat_number/messages', to: 'messages#index'
            delete '/application/:token/chat/:chat_number/message/:message_number', to: 'messages#delete'
            put '/application/:token/chat/:chat_number/message/:message_number', to: 'messages#update'
            get '/application/:token/chat/:chat_number/message/:message_number', to: 'messages#show'

            get '/application/:token/chat/:chat_number/message/search/:query', to: 'messages#partial_search'
        end
    end
end
