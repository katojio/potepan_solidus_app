require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  context 'HTMLでページを表示' do
    describe "商品詳細ページ" do
      let!(:taxon) { create(:taxon) }
      let!(:product) { create(:product, taxons: [taxon]) }
      let!(:related_products) { create_list(:product, 2, taxons: [taxon]) }

      before do
        get :show, params: { id: product.id }
      end

      it "レスポンスが正常である" do
        expect(response).to be_successful
      end

      it "商品詳細ページが表示される" do
        expect(response).to render_template :show
      end

      it '@productがアサインされる' do
        expect(assigns(:product)).to eq product
      end

      it '@imagesがアサインされる' do
        expect(assigns(:images)).to eq product.images
      end

      it '@related_productsがアサインされる' do
        expect(assigns(:related_products)).to match_array related_products
      end
    end
  end

  context 'Ajaxでページを表示' do
    let!(:product) { create(:product) }
    let!(:variant) { create(:variant) }

    describe "大きい方の画像" do
      it "レスポンスが正常である" do
        get :show_large_pic, params: { id: product.id, variant_id: variant.id }
        expect(response).to be_successful
      end
    end

    describe "小さい方の画像" do
      it "レスポンスが正常である" do
        get :show_small_pic, params: { id: product.id, variant_id: variant.id }
        expect(response).to be_successful
      end
    end
  end
end
