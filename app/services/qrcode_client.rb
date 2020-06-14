# require 'rqrcode'

class QrcodeClient

  # def initialize(visitor)
  #   @qrcode = RQRCode::QRCode.new(string_from(visitor))
  # end

  def generate(visitor:, path:)
    data = string_from(visitor)
    qrcode = RQRCode::QRCode.new(data)

    IO.binwrite(path, qrcode.as_png.to_s)
  end

  def generate2(resident:, visitor:, path:)
    data = string_from2(resident, visitor)
    qrcode = RQRCode::QRCode.new(data)

    IO.binwrite(path, qrcode.as_png.to_s)
  end

  def as_png
    @qrcode.as_png
  end

  def string_from(visitor)
    string = ""
    visitor.attributes.each do |key, value|
      next if skip_condition(key,value)
      string += format_key_value(key, value)
    end
    string
  end

  def string_from2(resident, visitor)
    string = "Resident Detail\n"
    string += "Phone = #{resident.phone}\n\n"

    attributes = visitor.attributes
    string += "Visitor Details\n"
    string += "Name = #{attributes['name']}\n"
    string += "IC = #{attributes['ic']}\n"
    if !attributes['car'].empty?
      string += "Car = #{attributes['car']}\n"
    end
    string += "\n"
    string += "Created\n"
    string += "#{attributes['created_at'].to_formatted_s.slice(0..-8)}"

    string
  end

  def format_key_value(key, value)
    new_key = case key
              when "ic"           then "IC"
              when "secret_key"   then "Secret key"
              when "created_at"   then "Generated"
              else
                key.to_s.capitalize
              end
    "#{new_key} = #{value}\n"
  end

  def skip_condition( key, value )
      (value == (String)) && value.empty? || key == "id"

  end

end



