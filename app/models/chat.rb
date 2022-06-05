class Chat < ApplicationRecord
    belongs_to :application, counter_cache: true
    has_many :messages, dependent: :destroy

    before_validation :init_message_counter, on: :create
    before_validation :increment_chat_number, on: :create

    validates :application_id, presence: true, uniqueness: {scope: :number}

    private
    def init_message_counter
        self.messages_count = 0
    end

    def increment_chat_number
        application = Application.find(self.application_id)
        if application.chats_count == 0
            self.number = 1
        else
            self.number = Chat.where(application_id: self.application_id).maximum(:number) + 1
        end
    end
end
