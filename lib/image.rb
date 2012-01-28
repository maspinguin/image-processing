require 'forwardable'
require 'chunky_png'
require 'matrix'

require 'image/filters'
require 'image/histogram'
require 'color'

class Image
  include Filters
  include Histogram

  extend Forwardable
  delegate [:get_pixel, :set_pixel, :width, :height, :save] => :@png

  def self.from_file(filename)
    new(ChunkyPNG::Image.from_file(filename))
  end

  def initialize(png)
    @png = png
  end

  def dup
    Image.new(@png.dup)
  end

  def each_pixel
    (0 ... @png.width).each do |x|
      (0 ... @png.height).each do |y|
        yield [x, y]
      end
    end
  end
end
