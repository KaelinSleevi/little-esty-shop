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

        visit merchant_bulk_discount_path(merchant1, bulk_discount2)

        expect(page).to have_content("#{bulk_discount2.id} Bulk Discounts")

        within("#discount-#{bulk_discount2.id}") do
            expect(page).to have_content("Discount: #{bulk_discount2.percentage_discount}%")
            expect(page).to have_content("Quantity Threshold: #{bulk_discount2.quantity_threshold}")
            expect(page).to_not have_content("Discount: #{bulk_discount1.percentage_discount}%")
            expect(page).to_not have_content("Quantity Threshold: #{bulk_discount1.quantity_threshold}")
        end
    end

    describe 'Then I see a link to edit the bulk discount, then I see a link to edit the bulk discount' do
        describe 'When I click this link, then I am taken to a new page with a form to edit the discount' do
            it 'And I see that the discounts current attributes are pre-poluated in the form' do
                merchant1 = Merchant.create!(name: "Bob")
                bulk_discount1 = merchant1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
                bulk_discount2 = merchant1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)

                visit merchant_bulk_discount_path(merchant1, bulk_discount1)

                expect(page).to have_link("Edit Discount")
                click_link("Edit Discount")
                expect(current_path).to eq(edit_merchant_bulk_discount_path(merchant1, bulk_discount1))
            end

            describe 'When I change any/all of the information and click submit' do
                it 'Then I am redirected to the bulk discounts show page, and I see that the discounts attributes have been updated' do
                    merchant1 = Merchant.create!(name: "Bob")
                    bulk_discount1 = merchant1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
                    bulk_discount2 = merchant1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)

                    visit merchant_bulk_discount_path(merchant1, bulk_discount1)
                    
                    expect(page).to have_link("Edit Discount")
                    click_link("Edit Discount")
                    
                    fill_in("Discount:", with: "15")
                    fill_in("Quantity Threshold:", with: "10")
                    click_button "Submit"

                    expect(current_path).to eq(merchant_bulk_discount_path(merchant1, bulk_discount1))
                end

                it 'And I see a notice when I do not fill out the form correctly' do
                    merchant1 = Merchant.create!(name: "Bob")
                    bulk_discount1 = merchant1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
                    bulk_discount2 = merchant1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)

                    visit merchant_bulk_discount_path(merchant1, bulk_discount1)
                    
                    expect(page).to have_link("Edit Discount")
                    click_link("Edit Discount")
                    
                    fill_in("Discount:", with: "10")
                    fill_in("Quantity Threshold:", with: " ")
                    click_button "Submit"

                    expect(current_path).to eq(edit_merchant_bulk_discount_path(merchant1, bulk_discount1))
                    expect(page).to have_content("All fields must be filled to submit.")
                end
            end
        end
    end
end