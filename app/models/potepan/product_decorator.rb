module Potepan::ProductDecorator
  def acquire_related_products
    return [] if taxon_ids.empty?

    Spree::Product.joins(:taxons)
                  .includes(master: %i(images default_price))
                  .where('spree_taxons.id IN (?) AND spree_products.id <> ?',
                         taxon_ids, id)
                  .distinct
                  .sample(Constants::DefaultSize::RELATED_IMAGES_LIMITATION)
  end

  Spree::Product.prepend self
end
