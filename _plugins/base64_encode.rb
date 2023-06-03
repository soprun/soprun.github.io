# https://crashlaker.github.io/python/2020/08/26/image_encode_decode_base64.html

# require "base64"

# require 'open-uri'
# require 'base64'
require 'pathname'

module Jekyll
  class Base64Encode < Liquid::Block
#   class Base64Encode < Liquid::Tag
    def initialize(tag_name, params, tokens)
    super
    @link = params.strip

#     puts tag_name
#     puts params
#     puts tokens
    end

    def render(context)

        value = rand(@rand)

        puts value.red

        exit 1

        puts @link.red
        # puts context

        if !File.exist?(@link)
            puts "\nWarning: not found file! \"".yellow + @link + "\"\n"
            exit 1
        end

        # Open file in read mode
        image = File.open(@link, "r")

        # Get the content of the file as a string
        imgstring = ""
        image.each { |line| imgstring << line }

        Base64.strict_encode64(imgstring)
    end
  end
end


Liquid::Template.register_tag("render_time", Jekyll::Base64Encode)

# module Base64Encode
#     class UpcaseConverter < Converter
#         safe true
#         priority :low
#
#         def matches(ext)
#           ext =~ /^\.upcase$/i
#         end
#
#         def output_ext(ext)
#           ".html"
#         end
#
#         def convert(content)
#           content.upcase
#         end
#     end
# end

# module Base64Encode
#     def img_to_base64_str(img)
#         buffered = io.BytesIO()
#         img.save(buffered, format="PNG")
#         buffered.seek(0)
#         img_byte = buffered.getvalue()
#         img_str = "data:image/png;base64," + base64.b64encode(img_byte).decode()
#         return img_str
#     end
#
#     def img_from_base64_str(msg)
#         msg = msg.replace("data:image/png;base64,", "")
#         msg = base64.b64decode(msg)
#         buf = io.BytesIO(msg)
#         img = Image.open(buf)
#         return img
#     end
# end


# Liquid::Template.register_filter(Base64Encode)
