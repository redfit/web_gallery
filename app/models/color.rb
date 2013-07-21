class Color < ActiveRecord::Base
  belongs_to :bookmark

  def format_by format=nil
    case format.to_s
    when "hsl"
      hsl = get_hsl
      "hsl(#{hsl[:hue]},#{hsl[:saturation]}%,#{hsl[:lightness]}%)"
    when "html"
     "##{"%02x" % red}#{"%02x" % green}#{"%02x" % blue}"
    else
     "rgba(#{red}, #{green}, #{blue}, #{alpha})"
    end
  end

  # from: http://www.rapidtables.com/convert/color/rgb-to-hsl.htm
  def get_hsl
    r = self.red.to_f / 255
    g = self.green.to_f / 255
    b = self.blue.to_f / 255
    max = [r, g, b].max
    min = [r, g, b].min
    hue = 0
    saturation = 0
    lightness = (max + min) / 2
    if max != min
      if lightness <= 0.5
        saturation = (max - min) / (max + min)
      else
        saturation = (max - min) / (2 - max - min)
      end
      cr = (max - r) / (max - min)
      cg = (max - g) / (max - min)
      cb = (max - b) / (max - min)
      if r == max
        hue = cb -cg
      elsif g == max
        hue = 2 + cr - cb
      else
        hue = 4 + cg - cr
      end
      hue = 60 * hue
      hue = hue + 360 if hue < 0
    end
    {hue: hue.to_i, saturation: (saturation*100).to_i, lightness: (lightness*100).to_i}
  end
end
