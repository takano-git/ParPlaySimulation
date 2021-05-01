class CreateGolfclubs < ActiveRecord::Migration[5.2]
  def change
    create_table :golfclubs do |t|
      t.string :name, default: "", null: false
      t.string :home_page_url
      t.string :strategy_video
      t.references :area, foreign_key: true

      t.timestamps
    end
  end
end
