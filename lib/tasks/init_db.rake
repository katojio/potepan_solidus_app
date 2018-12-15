# frozen_string_literal: true
# rubocop:disable all

namespace :init_db do
  desc "Initialize databases if databases aren't exist"
  task setup: :environment do
    raise 'Not allowed to run on production' if Rails.env.production?
    install_spree unless databases_exists?
  end

  desc 'Reset databases'
  task reset: :environment do
    raise 'Not allowed to run on production' if Rails.env.production?
    Rake::Task['db:drop'].execute if databases_exists?
    install_spree
  end

  def install_spree
    system 'bundle exec rails g spree:install --auto-accept'
    system 'bundle exec rails g solidus:auth:install'
  end

  def databases_exists?
    ActiveRecord::Base.connection
    true
  rescue ActiveRecord::NoDatabaseError
    false
  end
end