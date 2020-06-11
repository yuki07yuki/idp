# require 'rqrcode'

class QrcodeClient

  def initialize(visitor)
    @qrcode = RQRCode::QRCode.new(string_from(visitor))
  end

  def as_png
    @qrcode.as_png
  end

  # def as_svg
  #   @qrcode.as_svg
  # end

  def as_ansi
    @qrcode.as_ansi
  end

  def string_from(visitor)
    string = ""
    visitor.attributes.each_pair do |key, value|
      next if value.empty?
      string += "#{key} = #{value}\n"
    end
    string
  end

end



# # NOTE: showing with default options specified explicitly
# png = qrcode.as_png(
#   bit_depth: 1,
#   border_modules: 4,
#   color_mode: ChunkyPNG::COLOR_GRAYSCALE,
#   color: 'black',
#   file: nil,
#   fill: 'white',
#   module_px_size: 6,
#   resize_exactly_to: false,
#   resize_gte_to: false,
#   size: 120
# )

