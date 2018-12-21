# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( formtastic.css bootstrap.min.css jumbotron.css font-awesome.min.css popup.css owl.carousel.css owl.theme.css jquery-2.1.3.min.js jquery.easing.min.js jquery.mixitup.min.js jquery.popup.min.js bootstrap.min.js modernizr.js owl.carousel.min.js script.js ionicons.css tether.min.js)
