class AddDeletedAtToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :deleted_at, :datetime
  end
end
