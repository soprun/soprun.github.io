require 'html-proofer'
require "html/pipeline"
require "find"

output_dit = "$(PWD)/_site"

# make an out dir
Dir.mkdir(output_dit) unless File.exist?(output_dit)

pipeline = HTML::Pipeline.new([
  HTML::Pipeline::MarkdownFilter,
  HTML::Pipeline::TableOfContentsFilter,
],
gfm: true)

# iterate over files, and generate HTML from Markdown
Find.find("./docs") do |path|
  next unless File.extname(path) == ".md"
  contents = File.read(path)
  result = pipeline.call(contents)

  File.open(output_dit + "/#{path.split("/").pop.sub(".md", ".html")}", "w") { |file| file.write(result[:output].to_s) }
end

Jekyll::Hooks.register :site, :post_write do |site|
    options = {
        swap_urls: "^https://soprun.com/:/",
        :check_html => true,
        :check_img_http => true,
        :report_invalid_tags => true,
        :checks => [
            'Images',
            'Links',
            'Scripts',
            'Favicon',
            'OpenGraph',
            'Usage',
        ],
        :file_ignore =>  [
        ],
        :disable_external => true,
        :check_sri => true,
        :enforce_https => true,
        :allow_hash_href => true,
        :allow_missing_href => true,
        :only_4xx => true,
        :empty_alt_ignore => true,
        :url_ignore => [
            %r{^/cas},
            %r{^../images/}
        ],
    }

    HTMLProofer.check_directory(output_dit, options).run
end
