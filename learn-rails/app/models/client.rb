class Client < ActiveRecord::Base

  # as_enum :type_document, [dni: 0, ci: 1, ld: 2, ld: 3], prefix: true
  as_enum :type_document, %i{dni, ci, ld }, prefix: true

  has_many :invoices
  has_many :people, through: :invoices

  def new
  end

  def invoiced_more_people()
    self.people.group("name").order("amount DESC").sum("amount").first(5)
  end

  validates :firstname,
    presence: true,
    length: { in: 2..20 }
  validates :lastname,
    presence: true,
    length: { in: 2..20 }
  validates :type_document_cd,
    inclusion: { in: %w(DNI CI LD), message: "clave: %{value} no es valido" }
  validates :number_document, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 100000,
    less_than_or_equal_to: 99999999},
    uniqueness: {scope: :type_document_cd}
  validates :email,
    presence: true
  validates :phone,
    format: { with: /\A\+?[0-9]{2}[ .-]?[0-9]{3}[ .-]?[0-9]{7}[0-9]?\Z/ },
    allow_blank: true
  validates :address,
    allow_blank: true,
    length: { in: 2..40 }
  validates :code,
    format: { with: /\A[0-9]{2}-[0-9]{8}-[0-9]\Z/ },
    presence: true,
    uniqueness: true


end
