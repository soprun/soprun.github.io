module Jekyll
  class EnvironmentVariablesGenerator < Generator
    def generate(site)
      if ENV.fetch('SITE_URL', :default_need_not_be_a_string).to_s.strip.empty? != true
        url = ENV['SITE_URL'].to_s.strip
      end

      if ENV.fetch('CF_PAGES_URL', :default_need_not_be_a_string).to_s.strip.empty? != true
        url = ENV['CF_PAGES_URL'].to_s.strip
      end

      if url.to_s.strip.empty? != true
        site.config['url'] = url
      end

      if ENV.fetch('RELEASE_VERSION', :default_need_not_be_a_string).to_s.strip.empty? != true
        release_version = ENV['RELEASE_VERSION'].to_s.strip
      end

      if ENV.fetch('CF_PAGES_COMMIT_SHA', :default_need_not_be_a_string).to_s.strip.empty? != true
        release_version = ENV['CF_PAGES_COMMIT_SHA'].to_s.strip
      end

      if ENV.fetch('JEKYLL_SAFE', :default_need_not_be_a_string).to_s.strip.downcase == "true"
        config_safe = true
      end

      if ENV.fetch('JEKYLL_STRICT_MODE', :default_need_not_be_a_string).to_s.strip.downcase == "true"
        config_strict_mode = true
      end

#       puts site.config['url']
#       puts "\n"
#       puts url
#       puts "\n"
#       puts ENV['SITE_URL']
#       puts ENV['CF_PAGES_URL']
#       exit 1

      site.config['environment'] = ENV.fetch('JEKYLL_ENV', :default_need_not_be_a_string).to_s.strip || "production"
      site.config['safe'] = config_safe || false
      site.config['strict_mode'] = config_strict_mode || false
      site.config['release_version'] = release_version || ""

#       puts "\n"
#       puts "env: " + ENV['JEKYLL_ENV'].to_s.strip || ""
#       puts "env: " + site.config['env'].blue
#       puts "safe: " + site.config['safe'].to_s.strip.yellow
#       puts "url: " + site.config['url'].yellow
#       puts "strict_mode: " + site.config['strict_mode'].to_s.strip.yellow
#       puts "release_version: " + site.config['release_version'].yellow
#       puts "\n"
#       exit 1

#       if site.config['environment'] == "production"
#         if site.config['url'].to_s.strip.empty? == true
#           raise ArgumentError, "the value of the variable SITE_URL was not set!"
#         end
#         if site.config['release_version'].to_s.strip.empty? == true
#           raise ArgumentError, "the value of the variable RELEASE_VERSION was not set!"
#         end
#         # Enable safe mode
#         if site.config['safe'] != true
#           raise ArgumentError, "the value of the variable JEKYLL_SAFE was not set!"
#         end
#         if site.config['strict_mode'] != true
#           raise ArgumentError, "the value of the variable JEKYLL_STRICT_MODE was not set!"
#         end
#       end

      if site.config['strict_mode'] == true
        site.config['safe'] = true
        site.config['strict_front_matter'] = true
        site.config['liquid']['error_mode'] = 'strict'
        site.config['liquid']['strict_filters'] = true
        site.config['liquid']['strict_variables'] = true
        site.config['kramdown']['show_warnings'] = true

        site.config['quiet'] = true
        site.config['verbose'] = true
        site.config['profile'] = true
        site.config['regenerate'] = true
        site.config['incremental'] = true

#          puts site.config
#          exit 1
      end
    rescue => e
      puts "[ERROR]".red + ": An error of type " + "#{e.class}".red + " happened, message is " + "#{e.message}".yellow

      if site.config['environment'] === "production"
        exit 1
      end
    end
  end
end
