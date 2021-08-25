class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :card_id, default: "", null: false
      t.string :customer_id, default: "", null: false
      t.string :brand, default: "", null: false
      t.integer :exp_month
      t.integer :exp_year
      t.string :last4, default: "", null: false
      t.boolean :default_card, default: false, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
