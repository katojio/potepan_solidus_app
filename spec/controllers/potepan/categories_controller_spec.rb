require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "カテゴリーページ" do
    let!(:taxon) { create(:taxon) }
    let!(:product) { create(:product, taxons: [taxon]) }

    before do
      get :show, params: { id: taxon.id }
    end

    it "レスポンスが正常である" do
      expect(response).to be_successful
    end
    it "カテゴリーページが表示される" do
      expect(response).to render_template :show
    end
    it "@taxonがアサインされる" do
      expect(assigns(:taxon)).to eq taxon
    end
    it "@productsがアサインされる" do
      expect(assigns(:products)).to match_array(product)
    end
  end
end
