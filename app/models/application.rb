class Application < ApplicationRecord
    has_many :chats, dependent: :destroy

    before_validation :generate_token, on: :create
    before_validation :init_chat_counter, on: :create

    validates :token, presence: true
    validates :name, presence: true


    protected
    def generate_token
        self.token = SecureRandom.hex(10)
    end

    def init_chat_counter
        self.chats_count = 0
    end
end
