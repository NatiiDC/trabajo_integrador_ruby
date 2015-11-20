module ClientHelper
require 'date'

  def age (d)
    if d
      today = Date.today
      a = today.year - d.year
      a = a - 1 unless ( today.month > d.month or
          (today.month >= d.month and today.day > d.day) )
      a
    else
      "No se pudo realizar la operacion"
    end
  end

end
