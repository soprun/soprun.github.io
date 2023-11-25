require 'base64'
require 'pathname'

module Base64Filter
  def base64_encode(input)
    Base64.encode64(input)
  end

  # encoding_base64
  # Bash base64 encode and decode
  def encode_base64_hash(input)
    @url = Pathname.new(input)

    if !File.exist?(@url)
      puts "\nWarning: not found file!".yellow
      puts @url + "\n"

      "#{input}"
    else
      # Open file in read mode
      image = File.open(@url, 'r')

      # Get the content of the file as a string
      imgstring = ''
      image.each { |line| imgstring << line }

      Base64.strict_encode64(imgstring)
    end
  end

  def encode_base64_url(input)
    require 'mimemagic'

    @url = Pathname.new(input)

    if !File.exist?(@url)
      puts "\nWarning: not found file!".yellow
      puts @url + "\n"

      "#{input}"
    else

      output = encode_base64_hash(input)

      # Get image extension (e.g. ".png")
      imageext = File.extname(@url).gsub(/(\.\w+).*/, '\1').downcase

      # Generate dataURI schema
      @dataURI = 'data:image/'

      @dataURI += case imageext
                  when '.jpg'
                    'jpeg'
                  when '.svg'
                    'svg+xml'
                  else
                    # the MIME type is finally inferred from the file extension
                    imageext.delete('.')
                  end

      # yay, we encode it
      @dataURI += ';base64,'
      @dataURI += output
      @dataURI
    end
  end
end

Liquid::Template.register_filter(Base64Filter)
