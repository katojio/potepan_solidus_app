# frozen_string_literal: true

module Potepan
  # products_controller
  class ProductsController < ApplicationController
    def single_product
      @product  = Spree::Product.find(params[:id])
      @variant = Spree::Variant.find_by(product_id: @product.id)
      @images    = Spree::Image.where(viewable_id: @variant.id)
    end

  end
end
