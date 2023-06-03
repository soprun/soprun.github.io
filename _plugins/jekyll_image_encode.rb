# https://github.com/inetbiz/jekyll-vcard/blob/master/_plugins/jekyll-image-encode.rb
require "mimemagic"

module ImageEncodeCache
  @@cached_base64_codes = Hash.new

  def cached_base64_codes
    @@cached_base64_codes
  end

  def cached_base64_codes= val
    @@cached_base64_codes = val
  end
end

module Jekyll
  module Tags
    class ImageEncodeTag < Liquid::Tag
      include ImageEncodeCache

      def initialize(tag_name, url, options)
        super
        @url = url.strip
#         puts tag_name
#         puts url.
#         puts options
#         exit 1
      end

      def sendMessage(msg)
        puts "\n" + msg + " \"" + @url + "\"\n"
        puts "in " + @cs[:page]["path"].yellow + "\n"
      end

      def render(context)
        require 'open-uri'
        require 'base64'
        require 'pathname'

        # Get base path of html template
        @cs = context.registers

        # If a variable was passed to the liquid tag instead of a string
        # then read its value
        if context[@markup.strip]
            @imgsrc = context[@markup.strip]
        end

        basepath = @cs[:site].source

        # if a relative url was defined then the basepath is the same
        # of the page in which the image was requested.
#         if (@imgsrc.chars.first != "/")
#             basepath += @cs[:page]["dir"]
#         end

        @abspath = Pathname.new(File.join(basepath,  @url))


        if !File.exist?(@abspath)
            sendMessage("Warning: not found file!".yellow)
            exit 1
        else
            # Open file in read mode
                            image = File.open(@abspath, "r")

                            # Get the content of the file as a string
                            imgstring = ""
                            image.each { |line| imgstring << line }

                            # Get image extension (e.g. ".png")
                            imageext = File.extname(@url).gsub(/(\.\w+).*/, '\1').downcase;

                            # Generate dataURI schema
                            @dataURI = "data:image/";

                            case imageext
                               when ".jpg"
                                 @dataURI += "jpeg"
                               when ".svg"
                                 @dataURI += "svg+xml"
                               else
                                 # the MIME type is finally inferred from the file extension
                                 @dataURI += imageext.gsub('.', '')
                            end

                            @dataURI += ";base64,"

                            # yay, we encode it
                            @dataURI += Base64.strict_encode64(imgstring)

#                             getEncodingStatus("Encoded: ".green)
#                             getSizeStats()

                            @dataURI
        end
      end
    end
  end
end

Liquid::Template.register_tag('base64', Jekyll::Tags::ImageEncodeTag)
