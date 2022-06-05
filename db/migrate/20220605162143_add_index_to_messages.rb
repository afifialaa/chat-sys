class AddIndexToMessages < ActiveRecord::Migration[6.1]
  def change
    add_index :messages, [:chat_id, :number], unique: true
  end
end
