module Potepan
  class CategoriesController < ApplicationController
    def show
      @taxon    = Spree::Taxon.find(params[:id])
      @products = @taxon.products

      category_taxonomy_id = Spree::Taxonomy.find_by(name: "Categories").id
      category_taxons = Spree::Taxon.where(taxonomy_id:
        category_taxonomy_id).where.not(parent_id: nil)
      @large_categories = category_taxons.select { |t| t.parent_id == category_taxonomy_id }
      @small_categories = category_taxons.select { |t| t.parent_id != category_taxonomy_id }
    end
  end
end
