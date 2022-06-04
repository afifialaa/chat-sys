class Message < ApplicationRecord
    belongs_to :chat
    validates :content, presence: true
    validates :chat_id, presence: true

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
                        { match: {chat_id: 10}},
                        { wildcard: {content: query}}
                    ]
                }
            }
        })
    end

end
