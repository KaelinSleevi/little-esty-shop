require "rails_helper"

RSpec.describe 'As a merchant, when I visit my bulk discount show page' do
    it 'Then I see the bulk discounts quantity threshold and percentage discount' do
        merchant1 = Merchant.create!(name: "Bob")
        bulk_discount1 = merchant1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
        bulk_discount2 = merchant1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)

        visit merchant_bulk_discount_path(merchant1, bulk_discount1)

        expect(page).to have_content("#{bulk_discount1.id} Bulk Discounts")
        
        within("#discount-#{bulk_discount1.id}") do
            expect(page).to have_content("Discount: #{bulk_discount1.percentage_discount}%")
            expect(page).to have_content("Quantity Threshold: #{bulk_discount1.quantity_threshold}")
            expect(page).to_not have_content("Discount: #{bulk_discount2.percentage_discount}%")
            expect(page).to_not have_content("Quantity Threshold: #{bulk_discount2.quantity_threshold}")
        end
    end
end