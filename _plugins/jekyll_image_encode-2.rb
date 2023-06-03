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
        @pad = " " * 6
#         puts tag_name
#         puts url
#         puts options
#         exit
        super
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

        if !File.exist?(@url)
            sendMessage("Warning: not found file!".yellow)
            exit 1
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

#             "data:#{data_type};base64,#{encoded_image}"
           puts encoded_image
        end
      end
    end
  end
end

Liquid::Template.register_tag('base64_2', Jekyll::Tags::ImageEncodeTag)
