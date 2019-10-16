module Potepan
  class CategoriesController < ApplicationController
    def show
      @taxon    = Spree::Taxon.find(params[:id])
      @products = @taxon.products

      category_taxonomy = Spree::Taxonomy.find_by(name: 'Categories')
      category_taxons   = category_taxonomy.taxons unless category_taxonomy.nil?
      category_taxon    = category_taxons.find_by(name: 'Categories')
      if category_taxon.present?
        @large_categories = category_taxons.select { |t| t.parent_id == category_taxon.id }
        @small_categories = category_taxons.select { |t| t.parent_id != category_taxon.id }
      end
    end
  end
end
