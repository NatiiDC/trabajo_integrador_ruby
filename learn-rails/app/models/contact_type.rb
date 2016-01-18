class ContactType < ActiveRecord::Base

  as_enum :name, %i{skype, address, phone, email, mobile }, prefix: true

  validates :name,
    presence: true

end
