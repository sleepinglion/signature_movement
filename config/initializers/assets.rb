# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.1'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.1'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
style_prefix = 'app/assets/stylesheets/'
image_prefix    = 'app/assets/images/'

#css         = Dir["#{style_prefix}**/*.css"].map  { |x| x.gsub(style_prefix, '') }
image       = Dir["#{image_prefix}**/*"].map  { |x| x.gsub(image_prefix, '') }
scss        = Dir["#{style_prefix}**/*.scss"].map { |x| x.gsub(style_prefix, '') }

Rails.application.config.assets.precompile = (scss + image)
Rails.application.config.assets.precompile << Proc.new { |path|
  if path =~ /\.(eot|svg|ttf|woff|woff2)\z/
    true
  end
}