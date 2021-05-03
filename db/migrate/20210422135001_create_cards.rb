class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :card_id, default: "", null: false
      t.integer :customer_id, default: "", null: false
      t.string :customer_token, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
