class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :sku, :supplier_id, :weight, :width, :height, :depth, presence: true
end
