class Customer < ActiveRecord::Base
  has_many :customer_types
end
