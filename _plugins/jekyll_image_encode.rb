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
        @url = url.strip

#         puts tag_name
#         puts @url
#         exit 1
        @pad = " " * 6
        super
      end

#       def render(context)
#         encode_image
#       end

      def sendMessage(msg)
        puts "\n" + @pad + msg + " " + @url
        puts @pad + "in " + @cs[:page]["path"].yellow + "\n"
      end

      def render(context)
        require 'open-uri'
        require 'base64'
        require 'pathname'

        # Get base path of html template
        @cs = context.registers

        if !File.exist?(@url)
            sendMessage("Warning: not found!".yellow)
        else
            encoded_image = ''
            image_handle = open(@url)

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

Liquid::Template.register_tag('base64', Jekyll::Tags::ImageEncodeTag)
