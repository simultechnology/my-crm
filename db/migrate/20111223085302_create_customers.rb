class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :name_kana
      t.string :tel_number
      t.string :fax_number
      t.string :website
      t.string :leadsource
      t.string :status
      t.string :priority

      t.timestamps
    end
  end
end
