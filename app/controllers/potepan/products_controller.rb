module Potepan
  class ProductsController < ApplicationController
    def show
      @product  ||= Spree::Product.find(params[:id])
      @variants   = Spree::Variant.where(product_id: @product.id)
      @images     = @product.images

      taxonomy = Spree::Taxonomy.find_by(name: 'Categories')
      taxon = @product.taxons.find_by(taxonomy_id: taxonomy.id) unless taxonomy.nil?
      @related_products = taxon.present? ? taxon.products.reject{ |p| p.id == @product.id } : nil

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
