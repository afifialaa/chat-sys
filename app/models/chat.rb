class Chat < ApplicationRecord
    belongs_to :application
    has_many :messages

    validates :application_id, presence: true
end
