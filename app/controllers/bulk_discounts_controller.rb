class BulkDiscountsController < ApplicationController
    def index
        @merchant = Merchant.find(params[:merchant_id])
    end

    def show
        @merchant = Merchant.find(params[:merchant_id])
        @bulk_discount = BulkDiscount.find(params[:id])
    end

    def new
        @merchant = Merchant.find(params[:merchant_id])
    end

    def create
        @merchant = Merchant.find(params[:merchant_id])
        @bulk_discount = @merchant.bulk_discounts.new(discount_params)
        if @bulk_discount.save
            redirect_to merchant_bulk_discounts_path(@merchant)
          else
            redirect_to new_merchant_bulk_discount_path(@merchant)
        end
    end

    def edit
        @merchant = Merchant.find(params[:merchant_id])
        @bulk_discount = BulkDiscount.find(params[:id])
    end

    def update
        @merchant = Merchant.find(params[:merchant_id])
        @bulk_discount = BulkDiscount.find(params[:id])
        @bulk_discount.update(discount_params)
        if @bulk_discount.save
            redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
        else
            redirect_to edit_merchant_bulk_discount_path(@merchant, @bulk_discount)
        end
    end

    def destroy
        @merchant = Merchant.find(params[:merchant_id])
        BulkDiscount.find(params[:id]).destroy
        redirect_to merchant_bulk_discounts_path(@merchant)
    end

    private

    def discount_params
        params.permit(:percentage_discount, :quantity_threshold)
    end
end