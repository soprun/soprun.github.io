# # require "mimemagic"
# # require "base64"
# # require "pathname"
#
# module Base64Filter
#   def sendMessage(msg)
#     # puts "\n" + msg + " \"" + @url + "\"\n"
#     # puts "in " + @cs[:page]["path"].yellow + "\n"
#   end
#
#   def base64_encode (input)
#     Base64.encode64(input)
#   end
#
#    # encoding_base64
#   # Bash base64 encode and decode
#     def encode_base64_hash(input)
#     end
#
#     def encode_base64_url(input)
#         @url = Pathname.new(input)
#
# #       URI.open(input.strip) {|f|
# #         f.each_line {|line| p line}
# #       }
#
#       if !File.exist?(@url)
#           puts "\nWarning: not found file!".yellow
#           puts @url + "\n";
#
#           return "#{input}"
#
#          # URI.open(@url) {|f|
#          #   f.each_line {|line| p line}
#          # }
#       else
#             # Open file in read mode
#             image = File.open(@url, "r")
#
#             # Get the content of the file as a string
#             imgstring = ""
#             image.each { |line| imgstring << line }
#
#             # Get image extension (e.g. ".png")
#             imageext = File.extname(@url).gsub(/(\.\w+).*/, '\1').downcase;
#
#             # Generate dataURI schema
#             @dataURI = "data:image/";
#
#             case imageext
#                when ".jpg"
#                  @dataURI += "jpeg"
#                when ".svg"
#                  @dataURI += "svg+xml"
#                else
#                  # the MIME type is finally inferred from the file extension
#                  @dataURI += imageext.gsub('.', '')
#             end
#
#             # yay, we encode it
#             @dataURI += ";base64,"
#             @dataURI += Base64.strict_encode64(imgstring)
#             @dataURI
#             # sendMessage("Encoded: ".green)
#       end
#     end
# end
#
# Liquid::Template.register_filter(Base64Filter)
#
