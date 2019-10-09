module Potepan
  class ProductsController < ApplicationController
    def show
      @product  ||= Spree::Product.find(params[:id])
      @variants   = Spree::Variant.where(product_id: @product.id)
      @images     = @product.images

      # Search related images
      @related_products = []
      @related_images = []
      taxons = Spree::Product.find(params[:id]).taxons
      taxons.each do |t|
        t.products.each do |p|
          if p.id != @product.id && !@related_products.include?(p)
            @related_products << p
          end
        end
      end
      @related_products.each do |r|
        @related_images << r.images.first
      end

      respond_to do |format|
        format.html { render 'show' }
        format.js
      end
    end

    def show_large_pic
      @product  ||= Spree::Product.find(params[:id])
      @variant    = Spree::Variant.find(params[:variant_id])
      @images     = Spree::Image.where(viewable_id: @variant.id)
      return (render partial: 'image', collection: @images,
                     locals: { picture_size: 'large' })
    end

    def show_small_pic
      @product  ||= Spree::Product.find(params[:id])
      @variant    = Spree::Variant.find(params[:variant_id])
      @images     = Spree::Image.where(viewable_id: @variant.id)
      return (render partial: 'image', collection: @images,
                     locals: { picture_size: 'small' })
    end
  end
end
