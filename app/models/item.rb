class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items 
  has_many :invoices 
  has_many :transactions, through: :invoices 
  has_many :customers, through: :invoices 
  # has_many :invoice_items, through: :invoices 

  def self.find_items(keyword)
    where("name  ILIKE ?", "%#{keyword}%")
  end

    def self.item_with_most_revenue(number)
    Item.joins(invoice_items: {invoice: :transactions})
    .where(transactions: { result: 'success'})
    .group(:id).select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .order(revenue: :desc)
    .limit(number)
  end 
end
