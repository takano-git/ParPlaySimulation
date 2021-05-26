class CreateStrategyInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :strategy_infos do |t|
      t.references :user, foreign_key: true
      t.references :golfclub, foreign_key: true
      t.references :course, foreign_key: true
      t.references :hole, foreign_key: true
      t.integer :shot_id, null: false
      t.integer :location_name
      t.text :comment
      t.integer :pin_x
      t.integer :pin_y
      t.integer :map_size_x
      t.integer :map_size_y

      t.timestamps
    end
  end
end
