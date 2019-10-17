require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  describe "カテゴリーページ" do
    let!(:taxonomy)      { create(:taxonomy, name: 'Categories') }
    let!(:taxon_a)       { Spree::Taxon.find_by(name: 'Categories') }
    let!(:taxon_b)       { create(:taxon, taxonomy: taxonomy, parent_id: taxon_a.id) }
    let!(:taxon_c)       { create(:taxon, taxonomy: taxonomy, parent_id: taxon_a.id) }
    let!(:taxon_d)       { create(:taxon, taxonomy: taxonomy, parent_id: taxon_a.id) }
    let!(:taxon_d_a)     { create(:taxon, taxonomy: taxonomy, parent_id: taxon_d.id) }
    let!(:taxon_d_b)     { create(:taxon, taxonomy: taxonomy, parent_id: taxon_d.id) }
    let!(:product)       { create(:product, taxons: [taxon_b]) }
    let!(:other_product) { create(:product) }

    before do
      visit potepan_category_path(taxon_b.id)
    end

    context "カテゴリーページ全体について" do
      it "表示タイトルが正しいことを確認" do
        expect(page).to have_title 'Category - BIGBAG Store'
      end

      it "カテゴリー名がページ上部に表示されることを確認" do
        expect(page).to have_css('h2', text: "#{taxon_b.name}")
      end
    end

    context "カテゴリーツリーについて" do
      it "カテゴリー名がカテゴリーツリーに表示されることを確認" do
        expect(page).to have_css('li', text: "#{taxon_b.name}")
      end

      it "表示されるカテゴリー(liタグ)が合計7つであることを確認" do
        within find('#category') do
          expect(all('li').size).to eq(7)
        end
      end

      it "表示される大カテゴリーが合計3つであることを確認" do
        within find('#category') do
          expect(page).to have_selector '.collapseItem', count: 3
        end
      end

      it "カテゴリー詳細ページへのリンクが貼られていることを確認" do
        within find("#category#{taxon_c.id}") do
          expect(page).to have_link taxon_c.name, href: potepan_category_path(taxon_c.id)
        end
      end
    end

    context "カテゴリーに該当する商品一覧について" do
      it "カテゴリーに該当する商品の名前があることを確認" do
        expect(page).to have_content product.name
      end

      it "カテゴリーに該当する商品の価格があることを確認" do
        expect(page).to have_content product.display_price
      end

      it "カテゴリーに該当する商品の詳細ページへのリンクがあることを確認" do
        expect(page).to have_link(href: potepan_product_path(product.id))
      end

      it "カテゴリーに該当しない商品の名前がないことを確認" do
        expect(page).to have_no_content other_product.name
      end
    end
  end
end
