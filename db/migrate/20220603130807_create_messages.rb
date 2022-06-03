class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
        t.string :content, null: false 
        t.integer :number, null: false

        t.timestamps
    end
  end
end
