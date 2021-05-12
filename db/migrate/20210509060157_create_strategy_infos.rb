class CreateStrategyInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :strategy_infos do |t|
      t.integer :golfclub_id, null: false
      t.integer :course_id, null: false
      t.integer :hole_id, null: false
      t.integer :shot_id, null: false
      t.integer :user_id, null: false
      t.integer :location_name
      # 画像（photo, hole_map）はクラウドで保存なら削除
      t.integer :photo
      t.string :hole_map
      t.text :comment
      t.string :hole_map
      t.integer :pin_x
      t.integer :pin_y
      t.integer :map_size_x
      t.integer :map_size_y

      t.timestamps
    end
  end
end
