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

      # 関連画像を探す処理
      # 配列を準備
      taxon_ids = []
      product_ids = []

      # 表示している商品のidから、その商品の分類(Taxon)idを取得する
      classifications = Spree::Classification.where(product_id: params[:id])
      classifications.each do |c|
        taxon_ids << c.taxon_id
      end

      # Spree::Classificationモデルから、先ほど取得した1つ目のtaxon_idを持ち、かつproduct_idが表示している商品でない商品のidを取得する
      related_classifications = Spree::Classification.where(taxon_id: taxon_ids[0]).where.not(product_id: params[:id])
      related_classifications.each do |c|
        product_ids.push(c.product_id)
      end

      # 上と同じ処理を2つ目のtaxon_idを用いて行う
      related_classifications = Spree::Classification.where(taxon_id: taxon_ids[1]).where.not(product_id: params[:id])
      related_classifications.each do |c|
        product_ids.push(c.product_id)
      end

      # 配列を準備
      @products = []
      variants = []
      @related_images = []

      # これまでの処理で集めたproduct_idの集合を元に、関連商品の画像を取得する
      product_ids.each do |p|
        @products << Spree::Product.find(p)
        variants  << Spree::Variant.find_by(product_id: p)
      end
      variants.each do |v|
        @related_images << Spree::Image.find_by(viewable_id: v.id)
      end

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
