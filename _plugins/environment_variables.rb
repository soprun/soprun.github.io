module Jekyll
  class EnvironmentVariablesGenerator < Generator
    def generate(site)
      if ENV.fetch('JEKYLL_SAFE', :default_need_not_be_a_string).to_s.strip.downcase == "true"
        config_safe = true
      end

      if ENV.fetch('JEKYLL_STRICT_MODE', :default_need_not_be_a_string).to_s.strip.downcase == "true"
        config_strict_mode = true
      end

      if ENV.fetch('BASE_URL', :default_need_not_be_a_string).to_s.strip.empty? != true
        baseurl = ENV['BASE_URL'].to_s.strip
      end

      if ENV.fetch('CF_PAGES_URL', :default_need_not_be_a_string).to_s.strip.empty? != true
        baseurl = ENV['CF_PAGES_URL'].to_s.strip
      end

#       puts site.config
#       puts "\n"
#       puts ENV['BASE_URL']
#       puts ENV['CF_PAGES_URL']
#       exit 1

      site.config['env'] = ENV['JEKYLL_ENV'] || 'production'
      site.config['safe'] = config_safe || false
      site.config['baseurl'] = baseurl || ""
      site.config['strict_mode'] = config_strict_mode || false
      site.config['release_version'] = ENV['CF_PAGES_COMMIT_SHA'].to_s.strip || ""

#       puts "\n"
#       puts "env: " + ENV['JEKYLL_ENV'].to_s.strip || ""
#       puts "env: " + site.config['env'].blue
#       puts "safe: " + site.config['safe'].to_s.strip.yellow
#       puts "baseurl: " + site.config['baseurl'].yellow
#       puts "strict_mode: " + site.config['strict_mode'].to_s.strip.yellow
#       puts "release_version: " + site.config['release_version'].yellow
#       puts "\n"
#       exit 1

      if site.config['env'] == "production"
        if site.config['baseurl'].to_s.strip.empty?
          raise ArgumentError, "the value of the variable BASE_URL was not set!"
        end
        if site.config['release_version'].to_s.strip.empty?
          raise ArgumentError, "the value of the variable RELEASE_VERSION was not set!"
        end

        # Enable safe mode
        # if site.config['safe'] != true
        #   raise ArgumentError, "the value of the variable JEKYLL_SAFE was not set!"
        # end
        # if site.config['strict_mode'] != true
        #   raise ArgumentError, "the value of the variable JEKYLL_STRICT_MODE was not set!"
        # end
      end

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
      puts "An error of type " + "#{e.class}".red + " happened, message is " + "#{e.message}".yellow
      exit 1;
    end
  end
end
