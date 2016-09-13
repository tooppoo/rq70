# coding: utf-8

require 'pry'

pattern_counts = []

def get_rectangle_area(length, height)
  (length / 2 - height) * height
end

500.times {|l|
  length = l + 1
  next unless length % 4 == 0

  square_area = (length / 4) ** 2
#binding.pry

  (length / 4).times{|h1|
    height1 = h1 + 1
    rect_1 = get_rectangle_area(length, height1)
#binding.pry

    (length / 4).times{|h2|
      height2 = h2 + 1
      rect_2 = get_rectangle_area(length, height2)
#binding.pry

      next unless rect_1 + rect_2 == square_area
      next if pattern_counts.select{|item|
        rect_1 % item[:r1] == 0 && rect_2 % item[:r2] == 0
      }.size > 0

      pattern_counts << {r1: rect_1, r2: rect_2}
    }
  }
}
puts "patterns = #{pattern_counts.size}"
