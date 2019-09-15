# frozen_string_literal: true

module Potepan
  # products_controller
  class ProductsController < ApplicationController
    def single_product
      render 'potepan/single_product'
    end

  end
end
