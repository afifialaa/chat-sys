class Message < ApplicationRecord
    belongs_to :chat, counter_cache: true

    before_validation :increment_message_number, on: :create

    validates :content, presence: true
    validates :chat_id, presence: true, uniqueness: {scope: :number}


    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks


    index_name "chat-sys"

    def as_indexed_json(options = nil)
        self.as_json( only: [ :content, :chat_id] )
    end

    def self.partial_search(query, chat_id)
        self.search({
            query: {
                bool: {
                    must: [
                        { match: {chat_id: chat_id}},
                        { wildcard: {content: query}}
                    ]
                }
            }
        })
    end

    private
    def increment_message_number
        chat = Chat.find(self.chat_id)
        if chat.messages_count == 0
            self.number = 1
        else
            self.number = Message.where(chat_id: self.chat_id).maximum(:number) + 1
        end
    end

end
