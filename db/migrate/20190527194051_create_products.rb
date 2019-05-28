class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :ref_id
      t.string :name
      t.float :price
      t.bigint :score

      t.timestamps
    end
  end
end
