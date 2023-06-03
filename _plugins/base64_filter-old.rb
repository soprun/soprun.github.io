# require "base64"
# require "mimemagic"
#
# module Base64Filter
#   def base64_encode (input)
#     Base64.encode64(input)
#   end
#     def encode_base64_url(input)
#       @abspath = Pathname.new(input.strip)
#
#       if !File.exist?(@abspath)
#           puts "Warning: not found file!\n".yellow
#           puts @abspat
#           return
#       end
#
#       # Open file in read mode
#       image = File.open(@abspath, "r")
#
#       # Get the content of the file as a string
#       imgstring = ""
#       image.each { |line| imgstring << line }
#
#       # Get image extension (e.g. ".png")
#       imageext = File.extname(@abspath).gsub(/(\.\w+).*/, '\1').downcase;
#
#       # Generate dataURI schema
#       @dataURI = "data:image/";
#
#       case imageext
#          when ".jpg"
#            @dataURI += "jpeg"
#          when ".svg"
#            @dataURI += "svg+xml"
#          else
#            # the MIME type is finally inferred from the file extension
#            @dataURI += imageext.gsub('.', '')
#       end
#
#       @dataURI += ";base64,"
#
#       # yay, we encode it
#       @dataURI += Base64.strict_encode64(imgstring)
#
#       # sendMessage("Encoded: ".green)
#       # getSizeStats()
#
#       @dataURI
#
#       # puts @abspath
#       # exit 0
#       # input
#       "#{input}"
#     end
# end
#
#
