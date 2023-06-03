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
        @url = url.strip
        @pad = " " * 6

#         puts tag_name
#         puts url
#         puts options
#         exit
        super
      end

      def render(context)
        encode_image(context)
      end

        def getEncodingStatus(msg)
            puts "\n" + @pad + msg  + @abspath.to_s
            puts @pad + "in " + @cs[:page]["path"].red + "."
        end

      def encode_image(context)
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
        if (@imgsrc.chars.first != "/")
            basepath += @cs[:page]["dir"]
        end

         @abspath = Pathname.new(File.join(basepath,  @url))

        puts @imgsrc
        puts @url
        exit 0

        if !File.exist?(@abspath)
            getEncodingStatus("Warning: not found! ".yellow)
            exit 1
        else
#             encoded_image = ''
#             image_handle = open(@url)

             # Open file in read mode
            image = File.open(@url, "r")

            if self.cached_base64_codes.has_key? @url
              encoded_image = self.cached_base64_codes[@url]
            else
              # p "Caching #{@url} as local base64 string ..."
              encoded_image = Base64.urlsafe_encode64(image_handle.read)
              self.cached_base64_codes.merge!(@url => encoded_image)
            end

            data_type = MimeMagic.by_magic(image_handle)
            image_handle.close

            "data:#{data_type};base64,#{encoded_image}"
        end
      end
    end
  end
end

Liquid::Template.register_tag('base64_encoded2', Jekyll::Tags::ImageEncodeTag)
