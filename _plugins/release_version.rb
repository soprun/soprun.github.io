# Plugin to add environment variables to the `site` object in Liquid templates

module Jekyll
  class EnvironmentVariablesGenerator < Generator
    def generate(site)
      # site.config['env'] = ENV['JEKYLL_ENV'] || 'development'
      site.config['release_version'] = ENV['CF_PAGES_COMMIT_SHA'] || 'unknown'
      # Add other environment variables to `site.config` here...
    end
  end
end
