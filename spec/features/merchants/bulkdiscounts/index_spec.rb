require "rails_helper"

RSpec.describe 'As a merchant, when I visit the Bulk Discounts Index page' do
    describe 'I see all of my bulk discounts including their percentage discount and quantity thresholds' do
        it 'And each bulk discount listed includes a link to its show page' do
        merchant1 = Merchant.create!(name: "Bob")
        bulk_discount1 = merchant1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
        bulk_discount2 = merchant1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)

        visit merchant_bulk_discounts_path(merchant1)
        
        expect(page).to have_content("Bulk Discounts")
        
        within("#discount-#{bulk_discount1.id}") do
            expect(page).to have_content("Discount: #{bulk_discount1.percentage_discount}%")
            expect(page).to have_content("Quantity Threshold: #{bulk_discount1.quantity_threshold}")
        end

        within("#discount-#{bulk_discount2.id}") do
            expect(page).to have_content("Discount: #{bulk_discount2.percentage_discount}%")
            expect(page).to have_content("Quantity Threshold: #{bulk_discount2.quantity_threshold}")
        end

        expect(page).to have_link("See This Discount")
        end
    end

    # Merchant Bulk Discount Create

    # As a merchant
    # When I visit my bulk discounts index
    # Then I see a link to create a new discount
    # When I click this link
    # Then I am taken to a new page where I see a form to add a new bulk discount
    # When I fill in the form with valid data
    # Then I am redirected back to the bulk discount index
    # And I see my new bulk discount listed
    describe 'Then I see a link to create a new discount' do
        describe 'When I click this link' do
            it' I am taken to a new page where I see a form to add a new bulk discount' do
                merchant1 = Merchant.create!(name: "Bob")
                bulk_discount1 = merchant1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
                bulk_discount2 = merchant1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)
                
                visit merchant_bulk_discounts_path(merchant1)

                expect(page).to have_link("Create a New Discount")
                click_link("Create a New Discount")
                expect(current_path).to eq(new_merchant_bulk_discount(merchant1))
            end
        end

        describe 'When I fill in the form with valid data' do
            describe 'Then I am redirected back to the bulk discount index' do
                it 'And I see my new bulk discount listed' do
                    merchant1 = Merchant.create!(name: "Bob")
                    bulk_discount1 = merchant1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
                    bulk_discount2 = merchant1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)
                
                    visit merchant_bulk_discounts_path(merchant1)

                    click_link("Create a New Discount")

                    fill_in("Discount:", with: "15")
                    fill_in("Quantity Threshold:", with: "10")

                    click_button "Submit"
                    expect(current_path).to eq(merchant_bulk_discounts_path(merchant1))

                    expect(page).to have_content("Discount: 15%")
                    expect(page).to have_content("Quantity Threshold: 10")
                end
            end
        end
    end
end