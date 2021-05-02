class CreateHoles < ActiveRecord::Migration[5.2]
  def change
    create_table :holes do |t|
      t.integer :hole_number, null: false
      t.integer :number_of_pars, null: false
      t.references :golfclub, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
