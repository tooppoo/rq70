# coding: utf-8

module Q1
  class ::String
    def palindrom?
      self == self.reverse
    end
  end

  module Lazy
    # Ruby依存の解法
    class << self
      def exec(num)
        return false unless num.to_s(2).palindrom?
        return false unless num.to_s(8).palindrom?
        num.to_s.palindrom?
      end
    end
  end

  module Primitive
    # 原理に基づいた解法
    class ::Fixnum
      alias_method :to_decimal, :to_s

      def to_binary
        combert_to(principal_num: 2, base: self, char: [])
      end

      def to_octal
        combert_to(principal_num: 8, base: self, char: [])
      end

      private
      def combert_to(principal_num:, base:, char:)
        return char.reverse.join if base == 0
        combert_to(principal_num: principal_num, base: base / principal_num, char: char << (base % principal_num))
      end
    end

    class << self
      def exec(num)
        return false unless num.to_binary.palindrom?
        return false unless num.to_octal.palindrom?
        num.to_decimal.palindrom?
      end
    end
  end

  p (11..Float::INFINITY).lazy.find{|num|
    Q1.const_get(ARGV[0].capitalize).exec(num)
  }
end
