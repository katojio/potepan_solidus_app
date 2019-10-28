module Potepan
  class ProductsController < ApplicationController
    def show
      @product  ||= Spree::Product.find(params[:id])
      @variants   = Spree::Variant.where(product_id: @product.id)
      @images     = @product.images
      $RELATED_IMAGES_LIMITATION = 10
      @related_products = (@product.taxons.flat_map { |t| t.products.where.not(id: @product.id) }
                           ).uniq.take($RELATED_IMAGES_LIMITATION)

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
