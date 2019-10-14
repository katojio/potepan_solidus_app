module Potepan
  class CategoriesController < ApplicationController
    def show
      @taxon    = Spree::Taxon.find(params[:id])
      @products = @taxon.products

      category_taxonomy = Spree::Taxonomy.find_by(name: "Categories")
      category_taxons   = category_taxonomy.taxons
      @large_categories = category_taxons.select { |t| t.parent_id == category_taxonomy.id }
      @small_categories = category_taxons.select { |t| t.parent_id != category_taxonomy.id }
    end
  end
end
