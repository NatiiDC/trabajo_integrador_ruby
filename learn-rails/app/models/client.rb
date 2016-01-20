class Client < ActiveRecord::Base

  # as_enum :type_document, [dni: 0, ci: 1, ld: 2, ld: 3], prefix: true
  as_enum :type_document, %i{dni, ci, ld }, prefix: true

  has_many :invoices, dependent: :restrict_with_error
  has_many :people, through: :invoices
  has_many :contacts, inverse_of: :client
  accepts_nested_attributes_for :contacts, allow_destroy: true



  def invoiced_more_people()
    self.people.group("name").order("amount DESC").sum("amount").first(5)
  end

  validates :contacts,
    presence: true

  validates :firstname,
    presence: true,
    length: { in: 2..20 }
  validates :lastname,
    presence: true,
    length: { in: 2..20 }
  #No sea menor de edad
  validates :born,
    presence: true,
    date: {
      before: Proc.new { Time.now - 18.year }, message: "Debe tener mayoría de edad (18)."
    }
  validates :type_document_cd,
    presence: true,
    inclusion: { in: %w(DNI CI LD), message: "clave: %{value} no es valido" }
  validates :number_document, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 800000,
    less_than_or_equal_to: 99999999},
    uniqueness: {scope: :type_document_cd},
    presence: true
  # validates :phone,
  #   presence: false,
  #   format: { with: /\A(\+?[0-9]{2}[ .-]?[0-9]{3,4}[ .-]?[0-9]{7}[0-9]?){0,1}\Z/ }
  validates :code,
    format: { with: /\A[0-9]{2}-[0-9]{8}-[0-9]\Z/ },
    presence: true,
    uniqueness: true


end
