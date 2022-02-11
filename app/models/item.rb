class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_items(keyword)
    where("name  ILIKE ?", "%#{keyword}%")
  end
end
