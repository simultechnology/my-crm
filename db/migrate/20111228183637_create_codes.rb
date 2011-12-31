class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes, :id => false do |t|
      t.string :code_type, limit:2
      t.string :code_val, limit:3
      t.string :code_name
      t.integer :code_order
      t.boolean :del_flg

      t.timestamps
    end
  end
end
