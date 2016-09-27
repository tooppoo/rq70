# coding: utf-8

require 'pry'

module Q16
  module Quadrangle
    class << self
      def requtangles(length)
        reqts = (1...(length / 2)).to_a.map{|h|
          Requtangle.new(h, (length / 2) - h)
        }
        reqts.combination(2).map{|r1, r2| RequtangleCombination.new(r1, r2) }
      end

      def square(length)
        Square.new(length / 4, length / 4)
      end

      class RequtangleCombination
        attr_reader :r1, :r2

        def initialize(r1, r2)
          @r1, @r2 = r1, r2
        end

        def sum
          @r1 + @r2
        end

        def ==(other)
          other.r1 == @r1 && other.r2 == @r2 || other.r1 == @r2 && other.r2 == @r1
        end
      end
    end

    module InstanceMethods
      attr_reader :height, :width

      def initialize(h, w)
        @height, @width = h, w
      end

      def area
        @height * @width
      end
    end

    class Requtangle
      include InstanceMethods

      def ==(other)
        case other
        when Square
          self.area == other.area
        when Requtangle
          collapsed = @height == other.width && @width == other.height
          same = @height == other.height && @width == other.width
          return true if same || collapsed

          @height % other.height == 0 && @width % other.width == 0
        else
          raise ArgumentError
        end
      end

      def to_vertical
        new(@height + 1, @width - 1)
      end

      def vertiable?
        @width > 1
      end

      def +(other)
        self.area + other.area
      end
    end

    class Square
      include InstanceMethods

      def ==(other)
        case other
        when Square
          self.area == other.area
        else
          self.area == other
        end
      end
    end
  end

  def run
    matches = []

    (1..500).to_a.select{|len| len % 4 == 0 }.each{|length|
      square = Quadrangle.square(length)
      Quadrangle.requtangles(length).map{|combination|
        next unless combination.sum == square
        next if matches.include?(combination)

        matches << combination
        p matches, length, square.area, combination.sum
      }
    }
    puts matches.size
  end
end
