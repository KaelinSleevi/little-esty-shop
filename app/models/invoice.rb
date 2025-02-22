class Invoice < ApplicationRecord
  enum   status: {cancelled: 0, "in progress" => 1, completed: 2}

  has_many :transactions
  has_many :invoice_items
  has_many :items,   through: :invoice_items
  belongs_to :customer
  has_many :merchants, through: :items
  validates_presence_of :customer_id
  validates_presence_of :status
  validates_numericality_of :customer_id

  def self.incomplete_invoices
    joins(:invoice_items)
    .distinct
    .where
    .not("invoice_items.status = ?", 2)
    .order(:created_at)
  end

  def total_revenue
    invoice_items
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def discount
    Invoice.from(invoice_items.joins(item:[merchant: :bulk_discounts])
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .select('invoice_items.id, max(invoice_items.quantity * invoice_items.unit_price * (bulk_discounts.percentage_discount / 100.0)) as discounted_revenue')
    .group("invoice_items.id"))
    .sum('discounted_revenue')
  end
end
