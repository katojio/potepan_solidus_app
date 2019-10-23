require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "製品詳細ページ" do
    let!(:taxonomy)         { create(:taxonomy, name: 'Categories') }
    let!(:taxon)            { create(:taxon, taxonomy: taxonomy) }
    let!(:product)          { create(:product, taxons: [taxon]) }
    let!(:product_r1)       { create(:product, taxons: [taxon]) }
    let!(:product_r2)       { create(:product, taxons: [taxon]) }
    let!(:related_products) { taxon.products.reject{ |p| p.id == product.id } }
    let!(:other_product)    { create(:product) }

    before do
      visit potepan_product_path(product.id)
    end

    context "製品詳細ページ大枠について" do
      it "表示タイトルが正しいことを確認" do
        expect(page).to have_title 'Product - BIGBAG Store'
      end

      it "製品名がページ上部に表示されることを確認" do
        expect(page).to have_css('h2', text: "#{product.name}")
      end
    end

    context "製品詳細の表示部分について" do
      it "製品名、価格が表示されていることを確認" do
        within find('.singleProduct') do
          expect(page).to have_content product.name
          expect(page).to have_content product.display_price
        end
      end
    end

    context "関連画像の表示について" do
      it "関連画像の製品名、価格が表示されていることを確認" do
        within find('.featuredProductsSlider') do
          related_products.each do |p|
            expect(page).to have_content p.name
            expect(page).to have_content p.display_price
          end
        end
      end

      it "関連しない画像の製品名が表示されていないことを確認" do
        within find('.featuredProductsSlider') do
          expect(page).to have_no_content other_product.name
        end
      end
    end
  end
end
