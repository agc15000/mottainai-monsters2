class CreateMonsterMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :monster_messages do |t|
      t.text :content
      t.timestamps
    end
  end
end
