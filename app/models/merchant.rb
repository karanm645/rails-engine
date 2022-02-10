class Merchant < ApplicationRecord
  has_many :items

  def self.find_merchant(keyword)
    where("name  ILIKE ?", "%#{keyword}%").first
  end 
end
