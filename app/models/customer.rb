class Customer < ActiveRecord::Base
  has_many :customer_types
  has_many :contacts
end
