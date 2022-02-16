class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices 
  has_many :transactions, through: :invoices 
  has_many :customers, through: :invoices 
  has_many :invoice_items, through: :invoices 

  def self.find_merchant(keyword)
    where("name  ILIKE ?", "%#{keyword}%").first
  end 

  def self.top_merchants_by_revenue(number)
    Merchant.joins(:items, invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success' }, invoices: {status: 'shipped'})
    .group(:id).select("SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue, merchants.id, merchants.name")
    .order(total_revenue: :desc)
    .limit(number)
  end 

  def self.top_merchant_count(number)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success'}, invoices: {status: 'shipped'})
    .group(:id).select("SUM(invoice_items.quantity) AS total_count, merchants.*")
    .order(total_count: :desc)
    .limit(number)
  end 
end
