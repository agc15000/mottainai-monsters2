class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.references :user, null: false, foreign_key: true
      t.string :dall_e_image_url
      t.string :s3_image_url
      t.string :image_title

      t.timestamps
    end
  end
end
