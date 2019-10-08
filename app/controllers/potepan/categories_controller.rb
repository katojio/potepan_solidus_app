module Potepan
  class CategoriesController < ApplicationController
    def show
      @taxon    = Spree::Taxon.find(params[:id])
      @products = @taxon.products
      @images   = []
      @products.each do |p|
        @images << p.images.first
      end

      category_taxonomy = Spree::Taxonomy.find_by(name: "Categories")
      categories_taxonomy_id = category_taxonomy.id unless category_taxonomy.nil?
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
        @products_count[t.id] = Spree::Taxon.find(t.id).products.count
      end
    end
  end
end
