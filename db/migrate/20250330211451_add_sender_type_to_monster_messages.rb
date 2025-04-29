class AddSenderTypeToMonsterMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :monster_messages, :sender_type, :string
  end
end
