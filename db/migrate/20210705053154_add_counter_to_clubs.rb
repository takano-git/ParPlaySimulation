class AddCounterToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :counter, :integer, default: 0, null: false
  end
end
