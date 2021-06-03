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
      t.integer :photo_target_x
      t.integer :photo_target_y
      t.integer :photo_point_x
      t.integer :photo_point_y
      t.integer :photo_size_x
      t.integer :photo_size_y
      t.integer :map_target_x
      t.integer :map_target_y
      t.integer :map_point_x
      t.integer :map_point_y
      t.integer :map_shoot_x
      t.integer :map_shoot_y
      t.integer :map_size_x
      t.integer :map_size_y

      t.timestamps
    end
  end
end
