class Person < ActiveRecord::Base

  has_many :invoices, dependent: :restrict_with_error

end
