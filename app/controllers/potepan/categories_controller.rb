module Potepan
  class CategoriesController < ApplicationController
    def show
      classifications = Spree::Classification.where(taxon_id: params[:id])
      @products = []
      classifications.each do |c|
        @products << Spree::Product.find(c.product_id)
      end
      @variants = []
      @products.each do |p|
        @variants << Spree::Variant.find_by(product_id: p.id)
      end
      @images = []
      @variants.each do |v|
        @images << Spree::Image.find_by(viewable_id: v.id)
      end
    end
  end
end
