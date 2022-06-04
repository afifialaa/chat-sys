class Chat < ApplicationRecord
    belongs_to :application
    has_many :messages, dependent: :destroy

    before_validation :init_message_counter, on: :create

    validates :application_id, presence: true, uniqueness: {scope: :number}

    private
    def init_message_counter
        self.messages_count = 0
    end
end
