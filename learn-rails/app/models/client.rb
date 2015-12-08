class Client < ActiveRecord::Base

  # as_enum :type_document, [dni: 0, ci: 1, ld: 2, ld: 3], prefix: true
  as_enum :type_document, %i{dni, ci, ld }, prefix: true

  has_many :invoices

  default_scope { order("lastname ASC", "firstname ASC")  }

  def new
  end

  validates :firstname,
    presence: true,
    length: { in: 2..20 }
  validates :lastname,
    presence: true,
    length: { in: 2..20 }
  validates :type_document_cd,
    # inclusion: { in: %wdni, ci, ld), message: "clave: %{value} no es valido" },
    uniqueness: { scope: :number_document }
  validates :number_document, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 100000,
    less_than_or_equal_to: 99999999}
  validates :email,
    presence: true
  # validates :phone,
  #   allow_blank: true
  validates :address,
    allow_blank: true,
    length: { in: 2..40 }
  validates :code,
    # format: { with: /\^[0-9]{2}-[0-9]{8}-[0-9]\$/ },
    presence: true,
    uniqueness: true


end
