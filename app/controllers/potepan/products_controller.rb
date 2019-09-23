module Potepan
  class ProductsController < ApplicationController
    def show
      @product  ||= Spree::Product.find(params[:id])
      @variant    = Spree::Variant.find_by(product_id: @product.id)
      @images     = Spree::Image.where(viewable_id: @variant.id)

      # Search related images
      # Prepare empty array
      taxon_ids = []
      product_ids = []

      # Determine taxon_id from id of showing product
      classifications = Spree::Classification.where(product_id: params[:id])
      classifications.each do |c|
        taxon_ids << c.taxon_id
      end

      # Determine product_id which has first taxon_id and not has product_id of
      #  showing product from Spree::Classification
      related_classifications = Spree::Classification.where(taxon_id:
        taxon_ids[0]).where.not(product_id: params[:id])
      related_classifications.each do |c|
        product_ids.push(c.product_id)
      end

      # Same process as before by second taxon_id
      related_classifications = Spree::Classification.where(taxon_id:
        taxon_ids[1]).where.not(product_id: params[:id])
      related_classifications.each do |c|
        product_ids.push(c.product_id)
      end

      # Prepare array
      @products = []
      variants = []
      @related_images = []

      # Get related images by product_ids
      product_ids.each do |p|
        @products << Spree::Product.find(p)
        variants  << Spree::Variant.find_by(product_id: p)
      end
      variants.each do |v|
        @related_images << Spree::Image.find_by(viewable_id: v.id)
      end

      # JavaScript
      respond_to do |format|
        format.html { render 'show' }
        format.js
      end
    end

    def show_edit_l_pic
      @product  ||= Spree::Product.find(params[:id])
      @variant    = Spree::Variant.find(params[:variant_id])
      @images     = Spree::Image.where(viewable_id: @variant.id)
      # return the part of image rendering
      return (render partial: 'image', collection: @images,
                     locals: { picture_size: 'large' })
    end

    def show_edit_s_pic
      @product  ||= Spree::Product.find(params[:id])
      @variant    = Spree::Variant.find(params[:variant_id])
      @images     = Spree::Image.where(viewable_id: @variant.id)
      # return the part of image rendering
      return (render partial: 'image', collection: @images,
                     locals: { picture_size: 'small' })
    end
  end
end
