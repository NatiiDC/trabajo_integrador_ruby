class Person < ActiveRecord::Base

  has_many :invoices, dependent: :restrict_with_error

  validates :name,
    presence: true,
    length: { in: 2..20 }
  validates :code,
    format: { with: /\A[0-9]{2}-[0-9]{8}-[0-9]\Z/ },
    presence: true,
    uniqueness: true

end
