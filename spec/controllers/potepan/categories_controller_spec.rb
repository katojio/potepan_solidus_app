require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "カテゴリーページ" do
    let!(:taxonomy)        { create(:taxonomy, name: "Categories") }
    let!(:taxon)           { create(:taxon, taxonomy: taxonomy) }
    let!(:product)         { create(:product, taxons: [taxon]) }
    let!(:category_taxons) { taxonomy.taxons }

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
    it "@large_categoriesがアサインされる" do
      large_categories = category_taxons.select { |t| t.parent_id == taxon.id }
      expect(assigns(:large_categories)).to eq large_categories
    end
    it "@small_categoriesがアサインされる" do
      small_categories = category_taxons.select { |t| t.parent_id != taxon.id }
      expect(assigns(:small_categories)).to eq small_categories
    end
  end
end
