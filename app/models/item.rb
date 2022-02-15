class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items 

  def self.find_items(keyword)
    where("name  ILIKE ?", "%#{keyword}%")
  end
end
