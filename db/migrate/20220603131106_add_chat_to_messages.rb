class AddChatToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :chat, index: true
  end
end
