class BulkDiscountsController < ApplicationController
    def index
        @merchant = Merchant.find(params[:merchant_id])
        @bulk_discounts = BulkDiscount.all
    end

    def show
        @merchant = Merchant.find(params[:merchant_id])
        @bulk_discounts = BulkDiscount.find(params[:id])
    end
end