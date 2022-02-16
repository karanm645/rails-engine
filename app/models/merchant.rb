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

  def self.revenue_across_date(start_date, end_date)
   Merchant.joins(:items, invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success' }, invoices: {status: 'shipped'})
    .group(:id).select("SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue, merchants.created_at as start_date, merchants.id, merchants.name")
    .where("merchants.created_at >= start_date AND merchants.updated_at <= end_date")
    .order(total_revenue: :desc)
  end 

  def self.single_merchant_revenue(number)
    # Merchant.joins(:items, invoices: [:invoice_items, :transactions])
    # .where(merchants: { id: "number"}, transactions: { result: 'success'}, invoices: {status: 'shipped'})
    # .group(:id).select("SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue, merchants.id, merchants.name")

    Merchant.joins(invoices: [:invoice_items, :transactions])
    .where(merchants: {id: number}, transactions: { result: 'success'})
    .group(:id).select("merchants.id, SUM(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .first
    
  end 
end
