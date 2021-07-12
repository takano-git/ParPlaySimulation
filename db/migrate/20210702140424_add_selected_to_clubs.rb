class AddSelectedToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :selected, :boolean, default: false, null: false
  end
end
