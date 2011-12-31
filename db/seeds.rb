# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'


User.delete_all
User.create(
   name: 'crm',
   password: 'crm'
)
Code.delete_all
CSV.foreach(File.join(Rails.root, 'db', 'seeds', 'code.csv'), headers: true) do |row|
  c = Code.new
  c.code_type = row['CODE_TYPE']
  c.code_val = row['CODE_VAL']
  c.code_name = row['CODE_NAME']
  c.code_order = row['CODE_ORDER']
  c.del_flg = row['DEL_FLG']
  c.save!
end