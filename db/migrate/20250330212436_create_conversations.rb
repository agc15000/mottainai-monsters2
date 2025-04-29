class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_monster, null: false, foreign_key: true

      t.timestamps
    end
  end
end
