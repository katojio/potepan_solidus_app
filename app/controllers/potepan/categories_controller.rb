module Potepan
  class CategoriesController < ApplicationController
    def show
      @taxon    = Spree::Taxon.find(params[:id])
      @products = @taxon.products

      category_taxons   = Spree::Taxonomy.find_by(name: 'Categories').taxons
      category_taxon    = category_taxons.find_by(name: 'Categories')
      @large_categories = category_taxons.select { |t| t.parent_id == category_taxon.id }
      @small_categories = category_taxons.select { |t| t.parent_id != category_taxon.id }
    end
  end
end
