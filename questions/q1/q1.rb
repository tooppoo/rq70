# coding: utf-8

module Q1
  module Lazy
    # Ruby依存の解法
    class << self
      def exec(num)
        return false unless palindrom?(num, :binary)
        return false unless palindrom?(num, :octal)
        palindrom?(num, :decimal)
      end

      private
      def palindrom?(num, ary)
        ary_vals = {binary: 2, octal: 8, decimal: 10}

        comberted = num.to_s(ary_vals[ary])
        comberted == comberted.reverse
      end
    end
  end

  module Primitive
    # 原理に基づいた解法
    class ::Fixnum
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
        return false unless num.to_binary.reverse == num.to_binary
        return false unless num.to_octal.reverse == num.to_octal
        num.to_s.reverse == num.to_s
      end
    end
  end

  p (11..Float::INFINITY).lazy.find{|num|
    Q1.const_get(ARGV[0].capitalize).exec(num)
  }
end
