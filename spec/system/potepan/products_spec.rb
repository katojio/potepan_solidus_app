require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "製品詳細ページ" do
    let!(:product) { create(:product) }

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
  end
end
