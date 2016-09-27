#encoding: utf-8

module Ques18
  require 'pry'


  class Cake < Struct.new(:pieces, :squares)
    def berries
      #binding.pry
      (1..(2 * pieces)).to_a
    end

    def cut(berry: 1, whole: self.berries)
      piece = Piece.new(berry, whole, self.squares)

      while piece.next?
        next_piece = piece.next
        cut(berry: next_piece.berry, whole: next_piece.whole)
      end
      piece.whole.size == 0 && self.squares.include?(piece.berry + 1)
    end

    class Piece < Struct.new(:berry, :whole, :squares)
      def next?
        #binding.pry
        # 自分の個数と足すと平方数になる数があるか
        self.valid_berry_count.size() > 0
      end

      def next
        next_berry = valid_berry_count.pop
        remain_berries = whole.delete_if{|s| s == next_berry}
        Piece.new(next_berry, remain_berries, self.squares)
      end

      def valid_berry_count
        self.whole.delete_if{|s| s == self.berry}.select{|s| self.squares.include?(self.berry + s)}
      end
    end
  end

  n = 2

  while(true) do
    squares = (1..(2 * n)).map{|c| c ** 2}
    #binding.pry
    cake = Cake.new(n, squares)

    break if cake.cut
    n += 1
  end
  p n
end
