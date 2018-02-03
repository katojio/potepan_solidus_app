require 'generators/spree/install/install_generator.rb'

module AssetSetupTask
  extend Rake::DSL
  extend self

  def image(name, type = "jpeg")
    images_path = Pathname.new(File.dirname(__FILE__)) + "images"
    path = images_path + "#{name}.#{type}"
    return false if !File.exist?(path)
    path
  end

  def attachment_file_name(path)
    path.to_s.match(/images\/(.+\..+)\z/)[1]
  end

  def find_and_update_image!(images:, path:)
    product_image = images.find_by(attachment_file_name: attachment_file_name(path))
    raise "IMAGE FILE (#{path}) NOT FOUND IN #{variant.images}: reset database and reinstall sample data" unless product_image

    File.open(path) do |file|
      product_image.update!(attachment: file)
    end
  end

  namespace :_asset_loader do
    namespace :_force_reload do
      task setup: :environment do
        Spree::InstallGenerator.new.setup_assets

        begin
          products = {}
          products[:ror_baseball_jersey] = Spree::Product.find_by!(name: "Ruby on Rails Baseball Jersey")
          products[:ror_tote] = Spree::Product.find_by!(name: "Ruby on Rails Tote")
          products[:ror_bag] = Spree::Product.find_by!(name: "Ruby on Rails Bag")
          products[:ror_jr_spaghetti] = Spree::Product.find_by!(name: "Ruby on Rails Jr. Spaghetti")
          products[:ror_mug] = Spree::Product.find_by!(name: "Ruby on Rails Mug")
          products[:ror_ringer] = Spree::Product.find_by!(name: "Ruby on Rails Ringer T-Shirt")
          products[:ror_stein] = Spree::Product.find_by!(name: "Ruby on Rails Stein")
          products[:ruby_baseball_jersey] = Spree::Product.find_by!(name: "Ruby Baseball Jersey")
          products[:apache_baseball_jersey] = Spree::Product.find_by!(name: "Apache Baseball Jersey")
        rescue ActiveRecord::RecordNotFound => e
          puts 'could not identify the product record(s): check database and run migration once again'
          raise
        end

        images = {
          products[:ror_tote].master => [
            {
              attachment: image("ror_tote")
            },
            {
              attachment: image("ror_tote_back")
            }
          ],
          products[:ror_bag].master => [
            {
              attachment: image("ror_bag")
            }
          ],
          products[:ror_baseball_jersey].master => [
            {
              attachment: image("ror_baseball")
            },
            {
              attachment: image("ror_baseball_back")
            }
          ],
          products[:ror_jr_spaghetti].master => [
            {
              attachment: image("ror_jr_spaghetti")
            }
          ],
          products[:ror_mug].master => [
            {
              attachment: image("ror_mug")
            },
            {
              attachment: image("ror_mug_back")
            }
          ],
          products[:ror_ringer].master => [
            {
              attachment: image("ror_ringer")
            },
            {
              attachment: image("ror_ringer_back")
            }
          ],
          products[:ror_stein].master => [
            {
              attachment: image("ror_stein")
            },
            {
              attachment: image("ror_stein_back")
            }
          ],
          products[:apache_baseball_jersey].master => [
            {
              attachment: image("apache_baseball", "png")
            }
          ],
          products[:ruby_baseball_jersey].master => [
            {
              attachment: image("ruby_baseball", "png")
            }
          ]
        }

        products[:ror_baseball_jersey].variants.each do |variant|
          color = variant.option_value("tshirt-color").downcase
          puts "Loading color image (#{color}) for #{variant.product.name}"

          main_image_path = image("ror_baseball_jersey_#{color}", "png")
          find_and_update_image!(images: variant.images, path: main_image_path)

          back_image_path = image("ror_baseball_jersey_back_#{color}", "png")
          next unless back_image_path
          find_and_update_image!(images: variant.images, path: back_image_path)
        end

        images.each do |variant, attachments|
          puts "Loading images for #{variant.product.name}"

          attachments.each do |attachment|
            image_path = attachment[:attachment]
            find_and_update_image!(images: variant.images, path: image_path)
          end
        end
      end
    end
  end
end
