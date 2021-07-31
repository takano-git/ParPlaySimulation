class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :name, default: "", null: false
      t.string :plan_id, default: "", null: false

      t.timestamps
    end
  end
end
