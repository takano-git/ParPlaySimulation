class AddDeletedAtToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :delete_flg, :boolean, default: false, null: false
  end
end
