class AddConversationIdToMonsterMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :monster_messages, :conversation, null: false, foreign_key: true
  end
end
