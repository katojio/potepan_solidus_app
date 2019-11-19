class Potepan::StaticPagesController < ApplicationController
  def index
    @products = Spree::Product.all.take(10)
  end
end
