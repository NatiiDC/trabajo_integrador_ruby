class Invoice < ActiveRecord::Base

  belongs_to :client
  belongs_to :person

  paginates_per 5
  max_paginates_per 50

end
