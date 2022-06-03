class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
        t.integer :number, null: false
        t.integer :messages_count

        t.timestamps
    end
  end
end
