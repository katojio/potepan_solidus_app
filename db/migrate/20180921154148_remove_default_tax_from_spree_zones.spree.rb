# This migration comes from spree (originally 20170831201542)
# frozen_string_literal: true

class RemoveDefaultTaxFromSpreeZones < ActiveRecord::Migration[5.1]
  def change
    remove_column :spree_zones, :default_tax, :boolean, default: false
  end
end
