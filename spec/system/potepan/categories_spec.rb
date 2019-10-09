require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  describe "カテゴリーページ" do
    let!(:taxonomy) { create(:taxonomy) }
    let!(:taxon) { create(:taxon, taxonomy: taxonomy) }

    before do
      visit potepan_category_path(id: taxon.id)
    end

    it "カテゴリー名が表示されることを確認" do
      expect(page).to have_css('h2', text: "#{taxon.name}")
    end
  end
end
