class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum   status: {pending: 0, packaged: 1, shipped: 2}
 
  validates_presence_of :item_id
  validates_numericality_of :item_id
  validates_presence_of :invoice_id
  validates_numericality_of :invoice_id
  validates_presence_of :quantity
  validates_numericality_of :quantity
  validates_presence_of :unit_price
  validates_numericality_of :unit_price
  validates_presence_of :status

  def find_discount
   InvoiceItem.joins(item: [merchant: :bulk_discounts])
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .select('bulk_discounts.*')
    .group("bulk_discounts.id")
    .order("bulk_discounts.quantity_threshold desc")
  end
end

