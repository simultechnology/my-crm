class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :customer_id
      t.string :section_name
      t.string :contact_name
      t.string :contact_name_kana
      t.string :position
      t.string :office_tel_number
      t.string :mobile_tel_number
      t.string :contact_fax_number
      t.string :contact_email
      t.date :birthday
      t.string :family_member
      t.text :favorite
      t.text :contact_memo
      t.boolean :del_flg

      t.timestamps
    end
  end
end
