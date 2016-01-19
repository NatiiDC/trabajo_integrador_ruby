class ContactType < ActiveRecord::Base

  as_enum :name, %i{address, phone, email, mobile }, prefix: true

  validates :name_cd,
    presence: true

end
