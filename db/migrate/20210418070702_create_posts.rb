class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :category_id, null: false
      t.string :title, default: "", null: false
      t.string :comment, default: "", null: false
      t.integer :golfclub_id, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
