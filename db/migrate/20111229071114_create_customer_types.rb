class CreateCustomerTypes < ActiveRecord::Migration
  def change
    create_table :customer_types do |t|
      t.string :customer_type
      t.integer :customer_id
      t.string :customer_type_name
      t.string :zip_number
      t.string :prefecture_cd
      t.string :city
      t.string :oaza
      t.string :town
      t.string :building_name
      t.text :customer_type_memo
      t.boolean :del_flg

      t.timestamps
    end
  end
end
