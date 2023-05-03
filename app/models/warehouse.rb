class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :zip, :area, presence: true

  validates :code, length: { is: 3}

  validates :code, :name, uniqueness: true

  validates :zip, format: { with: /\A\d{5}-\d{3}\z/, message: "deve ter o formato 00000-000" }

end
