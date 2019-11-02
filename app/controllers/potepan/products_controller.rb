module Potepan
  class ProductsController < ApplicationController
    def show
      @product  ||= Spree::Product.find(params[:id])
      @variants   = Spree::Variant.where(product_id: @product.id)
      @images     = @product.images
      @related_products = @product.acquire_related_products

      respond_to do |format|
        format.html { render 'show' }
        format.js
      end
    end

    def show_large_pic
      @product  ||= Spree::Product.find(params[:id])
      @variant    = Spree::Variant.find(params[:variant_id])
      @images     = Spree::Image.where(viewable_id: @variant.id)
      render partial: 'image', collection: @images,
             locals: { picture_size: 'large' }
    end

    def show_small_pic
      @product  ||= Spree::Product.find(params[:id])
      @variant    = Spree::Variant.find(params[:variant_id])
      @images     = Spree::Image.where(viewable_id: @variant.id)
      render partial: 'image', collection: @images,
             locals: { picture_size: 'small' }
    end
  end
end
