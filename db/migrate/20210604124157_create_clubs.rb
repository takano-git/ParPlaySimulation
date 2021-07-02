class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.string :yarn_count_string, null: false
      t.integer :yarn_count_number
      t.string :detail, default: ""
      t.float :loft
      t.float :largo, null: false
      t.integer :weight, null: false
      t.string :balance_string, default: ""
      t.float :balance_number
      t.integer :frequency
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
