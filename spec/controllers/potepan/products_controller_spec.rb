require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  context 'when get show page only by html' do
    describe "#show" do
      let!(:product) { create(:product) }

      before do
        get :show, params: { id: product.id }
      end

      it "response successful" do
        expect(response).to be_successful
      end

      it "render show template" do
        expect(response).to render_template :show
      end

      it 'assigns @product' do
        expect(assigns(:product)).to eq product
      end
    end
  end

  context 'when get show page with Ajax' do
    let!(:product) { create(:product) }
    let!(:variant) { create(:variant) }

    describe "#large_pic" do
      it "response successful" do
        get :show_large_pic, params: { id: product.id, variant_id: variant.id }
        expect(response).to be_successful
      end
    end

    describe "#small_pic" do
      it "response successful" do
        get :show_small_pic, params: { id: product.id, variant_id: variant.id }
        expect(response).to be_successful
      end
    end
  end
end
