class CreateSelectedClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :selected_clubs do |t|
      t.integer :club_id, null: false, unique: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
