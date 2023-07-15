source 'https://rubygems.org'

gem 'jekyll', '~> 4.2.2'

group :jekyll_plugins do
  gem 'rake'
  gem 'rouge'
  gem 'kramdown'
  gem 'liquid'
  gem 'rspec'

  # To use retry middleware with Faraday v2.0+, install `faraday-retry` gem
  gem 'faraday-retry'

  gem 'jekyll-dotenv'
  gem 'jekyll-environment-variables'
  gem 'jekyll-seo-tag'
  gem 'jekyll-paginate'
#   gem 'jekyll-feed'
  gem 'jekyll-sitemap'
  gem 'jekyll-relative-links'

#   gem 'jekyll-notion'
#   gem 'jekyll-mentions'
#   gem 'jekyll-last-modified-at'

#   group :site do
#     gem "html-proofer", "~> 3.4" if ENV["PROOF"]
#     gem "jekyll-avatar"
#     gem "jekyll-mentions"
#     gem "jekyll-seo-tag"
#     gem "jekyll-sitemap"
#     gem "jemoji"
#   end

  #  if ENV["PROOF"]
#   gem 'html-pipeline', group: :development
#   gem 'find', group: :development
#   gem 'fileutils', group: :development
#   gem "typhoeus", "~> 1.4", group: :development

  group :development do
    gem "debug", group: :development
    gem "github_changelog_generator", group: :development

    # Automagically launches tests for changed files
    gem 'guard'
    gem 'guard-rspec', require: false
    # And updates gems when needed
    gem 'guard-bundler', require: false
    # And auto starts rails server
    gem 'guard-rails'
    # And auto runs migrations
    gem 'guard-migrate'
  end

  group :development, :test do
    gem "webrick", "~> 1.7"
    gem 'html-proofer', "~> 5.0"

    # Checks ruby code grammar
    gem 'rubocop', require: false
    gem 'rubocop-performance', require: false
    gem 'rubocop-rspec', require: false
    gem 'rubocop-rake', require: false
    gem 'rubocop-standard', require: false
    gem 'rubocop-minitest', require: false
    # With guard
    gem 'guard-rubocop', require: false
  end
end
