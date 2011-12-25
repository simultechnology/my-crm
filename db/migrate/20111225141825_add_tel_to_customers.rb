class AddTelToCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :kana
      t.string :tel_number
      t.string :fax_number
      t.string :website
      t.string :leadsource
      t.string :status
      t.string :priority
      t.text :memo

      t.timestamps
    end
  end
end
