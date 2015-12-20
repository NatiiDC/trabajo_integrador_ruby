class Invoice < ActiveRecord::Base

  belongs_to :client
  belongs_to :person

  paginates_per 10
  max_paginates_per 50

  default_scope { order("date_issue DESC")  }

end
