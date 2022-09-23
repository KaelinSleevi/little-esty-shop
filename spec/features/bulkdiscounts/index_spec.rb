require "rails_helper"

RSpec.describe 'When I visit the Bulk Discounts Index page' do
    describe 'I see all of my bulk discounts including their percentage discount and quantity thresholds' do
        it 'And each bulk discount listed includes a link to its show page' do
        merchant1 = Merchant.create!(name: "Bob")
        bulk_discount1 = merchant1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
        bulk_discount2 = merchant1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)

        visit merchant_bulk_discounts_path(merchant1)
        
        expect(page).to have_content("Bulk Discounts")
        
        within("#discount-#{bulk_discount1.id}") do
            expect(page).to have_content("Discount A: 20%")
            expect(page).to have_content("Quantity Threshold: 10")
        end

        within("#discount-#{bulk_discount2.id}") do
            expect(page).to have_content("Discount B: 30%")
            expect(page).to have_content("Quantity Threshold: 15")
        end

        end
    end
end