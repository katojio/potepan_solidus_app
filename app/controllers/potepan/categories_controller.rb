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

      categories_taxonomy_id = Spree::Taxonomy.find_by(name: "Categories").id
      category_taxons = Spree::Taxon.where(taxonomy_id:
        categories_taxonomy_id).where.not(parent_id: nil)
      @large_categories = []
      @small_categories = []
      @products_count = []
      category_taxons.each do |t|
        if t.parent_id == 1
          @large_categories << t
        else
          @small_categories << t
        end
        @products_count[t.id] = Spree::Classification.where(taxon_id: t.id).count
      end
    end
  end
end
