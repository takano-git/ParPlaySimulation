class CreateGolfclubs < ActiveRecord::Migration[5.2]
  def change
    create_table :golfclubs do |t|
      t.string :name, default: "", null: false
      t.string :district, default: "", null: false
      t.integer :prefecture, default: 0, null: false
      t.string :home_page_url
      t.string :strategy_video

      t.timestamps
    end
  end
end
