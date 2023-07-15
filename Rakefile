require 'html-proofer'
# require 'guard-bundler'

# https://github.com/guard/guard-bundler
# guard :bundler do
#   watch('Gemfile')
# end

# task default: [:check]

desc "Check >> HTMLProofer"
task :check do
  # Dir.mkdir(".jekyll-cache") unless File.exist?(".jekyll-cache")
  # Dir.mkdir(".jekyll-cache/html-proofer") unless File.exist?(".jekyll-cache/html-proofer")

  options = {
      # :swap_urls => '^/soprun.com/:/',
      :check_html => true,
      :check_img_http => true,
      :report_invalid_tags => true,
      :checks => [
          'Links',
          'Images',
          'Scripts',
          'Favicon',
          'OpenGraph',
          'Usage',
          'HtmlCheck'
      ],
      :file_ignore =>  [
          %r{.*/CAS-Protocol-Specification.html}
      ],
      :disable_external => true,
      :check_sri => false,
      :enforce_https => true,
      :allow_hash_href => true,
      :allow_missing_href => true,
      :only_4xx => false,
      :empty_alt_ignore => false,
      :url_ignore => [
#           %r{^/assets},
      ],
      :extension => ".htm",
      :cache => {
        :timeframe => {
            :external => "2d",
            :internal => "1h"
        },
        :cache_file => "html-proofer.json",
        :storage_dir => ".jekyll-cache/html-proofer"
      },
      :parallel => {
        :in_processes => 4
      },
      :log_level => "debug",
      :typhoeus => {
        :verbose => true,
        :ssl_verifyhost => 2,
        :followlocation => true,
        :connecttimeout => 10,
        :timeout => 30,
      }
  }

  # test your out dir!
  HTMLProofer.check_directory("_site", options).run
end

# https://github.com/gjtorikian/html-proofer#adjusting-for-a-baseurl
# require "html-proofer"

# task :test do
#   sh "bundle exec jekyll build"
#   options = { swap_urls: "^/BASEURL/:/" }
#   HTMLProofer.check_directory("./_site", options).run
# end
#
# abort('Please run this using `bundle exec rake`') unless ENV["BUNDLE_BIN_PATH"]

# desc "Test the website"
# task :test => [:build, 'html:check'] do
#   options = {
#     :check_sri => true,
#     :check_external_hash => true,
#     :check_html => true,
#     :check_img_http => true,
#     :check_opengraph => true,
#     :enforce_https => true,
#     :cache => {
#       :timeframe => '6w'
#     }
#   }
#   begin
#     HTMLProofer.check_directory(".", options).run
#   rescue => msg
#     puts "#{msg}"
#   end
# end
#
# task :default => [:test]
#
# HTMLProofer.check_directories(["out/"], { :extension => ".htm", :parallel => { :in_processes => 3} })


desc "Check >> [rubocop] Checks any changed ruby file for code grammar"
# https://github.com/yujinakayama/guard-rubocop
task :rubocop do
    watch(%r{^(.+)\.rb$}) { |m| "#{m[1]}.rb" }
end
