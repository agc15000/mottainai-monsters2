class CreateUserMonsters < ActiveRecord::Migration[7.1]
  def change
    create_table :user_monsters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :monster, null: false, foreign_key: true
      t.string :food_name
      t.string :monster_name
      t.text :message

      t.timestamps
    end
  end
end
