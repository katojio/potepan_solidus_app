# frozen_string_literal: true

module Potepan
  # products_controller
  class ProductsController < ApplicationController
    # GET /potepan/products/:id
    # params[:id]
    def single_product
      @product  ||= Spree::Product.find(params[:id])
      @variant    = Spree::Variant.find_by(product_id: @product.id)
      @images     = Spree::Image.where(viewable_id: @variant.id)
      # JavaScriptへの対応
      respond_to do |format|
      format.html { render 'single_product' }
      format.js
      end
    end

    # GET/potepan/products/:id/edit_l_pic
    # params[:id], params[:variant_id]
    def single_product_edit_l_pic
      @product  ||= Spree::Product.find(params[:id])
      @variant    = Spree::Variant.find(params[:variant_id])
      @images     = Spree::Image.where(viewable_id: @variant.id)
      # 画像のレンダリング部分を返す
      return (render partial: "image", collection: @images, locals: {picture_size: "large"})
    end

    # GET/potepan/products/:id/edit_s_pic
    # params[:id], params[:variant_id]
    def single_product_edit_s_pic
      @product  ||= Spree::Product.find(params[:id])
      @variant    = Spree::Variant.find(params[:variant_id])
      @images     = Spree::Image.where(viewable_id: @variant.id)
      # 画像のレンダリング部分を返す
      return (render partial: "image", collection: @images, locals: {picture_size: "small"})
    end

  end
end
