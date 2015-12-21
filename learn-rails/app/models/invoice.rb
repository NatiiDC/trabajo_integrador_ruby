class Invoice < ActiveRecord::Base

  belongs_to :client
  belongs_to :person

  paginates_per 10
  max_paginates_per 50

validates :description,
  presence: true,
  length: { maximum: 200 }
validates :amount,
  presence: true,
  numericality: {
    greater_than: 0,
    less_than_or_equal_to: 1000000000
  }
validates :date_issue,
  presence: true
validates :client_id,
  presence: true
validates :person_id,
  presence: true


end
