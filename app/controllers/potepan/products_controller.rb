module Potepan
  class ProductsController < ApplicationController
    def show
      @product  ||= Spree::Product.find(params[:id])
      @variants   = Spree::Variant.where(product_id: @product.id)
      @variant    = @variants.first
      @images     = Spree::Image.where(viewable_id: @variant.id)

      # Search related images
      taxon_ids = []
      product_ids = []

      classifications = Spree::Classification.where(product_id: params[:id])
      classifications.each do |c|
        taxon_ids << c.taxon_id
      end

      related_classifications = Spree::Classification.where(taxon_id:
        taxon_ids[0]).where.not(product_id: params[:id])
      related_classifications.each do |c|
        product_ids.push(c.product_id)
      end

      related_classifications = Spree::Classification.where(taxon_id:
        taxon_ids[1]).where.not(product_id: params[:id])
      related_classifications.each do |c|
        product_ids.push(c.product_id)
      end

      @products = []
      variants = []
      @related_images = []

      product_ids.each do |p|
        product = Spree::Product.find(p)
        unless @products.include?(product)
          @products << product
          variants  << Spree::Variant.find_by(product_id: p)
        end
      end
      variants.each do |v|
        image = Spree::Image.find_by(viewable_id: v.id)
        unless @related_images.include?(image)
          @related_images << image
        end
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
