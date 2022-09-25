require "rails_helper"


RSpec.describe "the merchant invoices show"  do
    describe 'I see all information related to that invoice' do
        it 'can display the invoice id' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")

            visit merchant_invoice_path(merchant1, invoice_1)
            expect(page).to have_content("Invoice: #{invoice_1.id}")
        end

        it 'can display the invoice status' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")

            visit merchant_invoice_path(merchant1, invoice_1)
            expect(page).to have_content("Invoice Status:")
        end

        it 'can display the date format for its creation date' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
            
            visit merchant_invoice_path(merchant1, invoice_1)
            
            expect(page).to have_content("Created: #{invoice_1.created_at.strftime("%A,%B %d, %Y")}")
        end

        it 'can display the customers first and last name' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")

            visit merchant_invoice_path(merchant1, invoice_1)
            expect(page).to have_content("Customer: #{customer1.first_name} #{customer1.last_name}")
        end

        describe 'I can see the item information within that invoice' do
            it 'can display the item name' do
                merchant1 = Merchant.create!(name: "Bob")
                merchant2 = Merchant.create!(name: "Mark")
                customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
                invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
                item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
                item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
                item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
                item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
                invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
                invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 1, status: 0)
                invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 1, status: 0)

                visit merchant_invoice_path(merchant1, invoice_1)

                expect(page).to have_content("#{item1.name}")
                expect(page).to have_content("#{item2.name}")
                expect(page).to have_content("#{item3.name}")
                expect(page).to_not have_content("#{item4.name}")
            end
       
            it 'can display the quantity of that item' do
                merchant1 = Merchant.create!(name: "Bob")
                merchant2 = Merchant.create!(name: "Mark")
                customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
                invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
                item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
                item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
                item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
                item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
                invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
                invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 1, status: 0)
                invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 1, status: 0)
                

                visit merchant_invoice_path(merchant1, invoice_1)

                expect(page).to have_content("#{invoice_item1.quantity}")
                expect(page).to have_content("#{invoice_item2.quantity}")
                expect(page).to have_content("#{invoice_item3.quantity}")
            end

            it 'can display the price that item sold for' do
                merchant1 = Merchant.create!(name: "Bob")
                merchant2 = Merchant.create!(name: "Mark")
                customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
                invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
                item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
                item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
                item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
                item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
                invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
                invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 1, status: 0)
                invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 1, status: 0)

                visit merchant_invoice_path(merchant1, invoice_1)
                
                expect(page).to have_content("#{item1.unit_price}")
                expect(page).to have_content("#{item2.unit_price}")
                expect(page).to have_content("#{item3.unit_price}")
            end

            it 'can display the invoice item status' do
                merchant1 = Merchant.create!(name: "Bob")
                merchant2 = Merchant.create!(name: "Mark")
                customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
                invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
                item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
                item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
                item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
                item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
                invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
                invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 1, status: 0)
                invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 1, status: 0)    

                visit merchant_invoice_path(merchant1, invoice_1)
                
                expect(page).to have_content("#{invoice_item1.status}")
                expect(page).to have_content("#{invoice_item2.status}")
                expect(page).to have_content("#{invoice_item3.status}")
            end
        end

        describe 'I can see the total revenue' do
            it 'from all merchant items within this invoice' do
                merchant1 = Merchant.create!(name: "Bob")
                merchant2 = Merchant.create!(name: "Mark")
                customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
                invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
                item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
                item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
                item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
                item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
                invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
                invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 1, status: 0)
                invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 1, status: 0)    

                visit merchant_invoice_path(merchant1, invoice_1)
 
                expect(page).to have_content("Total Revenue for Invoice #{invoice_1.id}: $0.06")
            end
        end

        describe 'I see that each invoice item status is a select field' do
            describe 'And I see that the invoice items current status is selected' do
                it 'And I see that the invoice items current status is selected' do
                    merchant1 = Merchant.create!(name: "Bob")
                    merchant2 = Merchant.create!(name: "Mark")
                    customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
                    invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
                    item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
                    item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
                    item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
                    item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
                    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
                    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 1, status: 0)
                    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 1, status: 0)    

                    visit merchant_invoice_path(merchant1, invoice_1)

                    expect(page).to have_content("Invoice Status:")
                    expect(page.has_field? 'status').to eq(true)
                    expect(page).to have_content("cancelled")
                end
            end

            describe 'When I click this select field' do
                describe 'Then I can select a new status for the Item' do
                    describe 'And next to the select field I see a button to "Update Item Status"' do
                        it ' I click this button I am taken back to the merchant invoice show page And I see that my Items status has now been updated' do
                            merchant1 = Merchant.create!(name: "Bob")
                            merchant2 = Merchant.create!(name: "Mark")
                            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
                            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
                            item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
                            item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
                            item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
                            item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
                            invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
                            invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 1, status: 0)
                            invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 1, status: 0)    

                            visit merchant_invoice_path(merchant1, invoice_1)

                            expect(page).to have_content("Invoice Status:")
                            expect(page).to have_content("cancelled")

                            select "in progress", from: "Status"
                            click_button "Update Invoice Status"
                            expect(page).to have_content("in progress")
                        end
                    end
                end
            end
        end

        describe 'When I visit my merchant invoice show page' do
            describe 'Then I see the total revenue for my merchant from this invoice (not including discounts)' do
                it 'And I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation' do
                    merchant_1 = Merchant.create!(name: "Bob")
                    merchant_2 = Merchant.create!(name: "Mark")
                    5.times do
                        create(:random_customer)
                    end
            
                    invoice_1 = create(:random_invoice, customer: Customer.all[0])
                    invoice_2 = create(:random_invoice, customer: Customer.all[1])
                    invoice_3 = create(:random_invoice, customer: Customer.all[2])
                    invoice_4 = create(:random_invoice, customer: Customer.all[3])
                    invoice_5 = create(:random_invoice, customer: Customer.all[4])
            
                    item_1 = create(:random_item, merchant_id: merchant_1.id)
                    item_2 = create(:random_item, merchant_id: merchant_1.id)
                    item_3 = create(:random_item, merchant_id: merchant_1.id)
                    item_4 = create(:random_item, merchant_id: merchant_2.id)
                    item_5 = create(:random_item, merchant_id: merchant_2.id)
            
                    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3635, status: 'shipped')
                    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 31, unit_price: 13635, status: 'packaged')
                    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 13, unit_price: 1335, status: 'shipped')
                    invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 30, unit_price: 1335, status: 'pending')
                    invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 12, unit_price: 1365, status: 'packaged')
            
                    bulk_discount1 = merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
                    bulk_discount2 = merchant_1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)
            
                    visit merchant_invoice_path(merchant_1, invoice_3)

                    expect(page).to have_content("Total Revenue for Invoice #{invoice_3.id}: $173.55")
                    expect(page).to have_content("Total Discounted Revenue for Invoice #{invoice_3.id}: $34.71")
                end
            end

            describe 'Next to each invoice item I see a link to the show page' do
                it 'And it is for the bulk discount that was applied (if any)' do
                    merchant_1 = Merchant.create!(name: "Bob")
                    merchant_2 = Merchant.create!(name: "Mark")
                    5.times do
                        create(:random_customer)
                    end
            
                    invoice_1 = create(:random_invoice, customer: Customer.all[0])
                    invoice_2 = create(:random_invoice, customer: Customer.all[1])
                    invoice_3 = create(:random_invoice, customer: Customer.all[2])
                    invoice_4 = create(:random_invoice, customer: Customer.all[3])
                    invoice_5 = create(:random_invoice, customer: Customer.all[4])
            
                    item_1 = create(:random_item, merchant_id: merchant_1.id)
                    item_2 = create(:random_item, merchant_id: merchant_1.id)
                    item_3 = create(:random_item, merchant_id: merchant_1.id)
                    item_4 = create(:random_item, merchant_id: merchant_2.id)
                    item_5 = create(:random_item, merchant_id: merchant_2.id)
            
                    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3635, status: 'shipped')
                    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 31, unit_price: 13635, status: 'packaged')
                    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 13, unit_price: 1335, status: 'shipped')
                    invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 30, unit_price: 1335, status: 'pending')
                    invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 12, unit_price: 1365, status: 'packaged')
            
                    bulk_discount1 = merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
                    bulk_discount2 = merchant_1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)
            
                    visit merchant_invoice_path(merchant_1, invoice_1)

                    expect(page).to have_link("Discount Applied")
                    click_link "Discount Applied"
                    
                    expect(current_path).to eq(merchant_bulk_discount_path(merchant1, bulk_discount1))
                end
            end
        end
    end
end