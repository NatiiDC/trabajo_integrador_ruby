class Contact < ActiveRecord::Base

  belongs_to :client
  belongs_to :contact_type

  validates :contact,
    presence: true

end
