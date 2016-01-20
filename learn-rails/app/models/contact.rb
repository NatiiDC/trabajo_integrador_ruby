class Contact < ActiveRecord::Base

  belongs_to :client
  belongs_to :contact_type

  def name_type
    ContactType.find(self.contact_type_id).name_cd
  end

  validates :contact,
    presence: true

end
