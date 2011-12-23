class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null:false, limit:100
      t.string :password
      t.boolean :del_flg

      t.timestamps
    end
  end
end
