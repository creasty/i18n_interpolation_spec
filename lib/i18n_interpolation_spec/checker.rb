module I18nInterpolationSpec
  module Checker
    class << self

      def except?(patterns, key)
        patterns.any? { |pattern|  pattern === key }
      end

      def check(t1, t2, except, &checker)
        i1, i2 = interpolations(t1), interpolations(t2)

        missing_keys = {}

        (i1.keys & i2.keys).each do |key|
          a1, a2 = i1[key], i2[key]
          diff = (a1 - a2) | (a2 - a1)
          next if except? except, key
          missing_keys[key] = diff if checker[key, a1, a2, diff]
        end

        missing_keys
      end

      def strict_check(t1, t2, except: [])
        check t1, t2, except do |key, a1, a2, diff|
          diff.any?
        end
      end

      def loose_check(t1, t2, except: [])
        check t1, t2, except do |key, a1, a2, diff|
          a1.any? && a2.any? && (diff == a1 | a2)
        end
      end

      def interpolations(t)
        result = {}

        rec = ->(t, scopes) do
          if t.is_a? Hash
            t.each do |(k, v)|
              rec.call v, [*scopes, k]
            end
          elsif t.is_a? Array
            t.each_with_index do |v, i|
              rec.call v, [*scopes, i]
            end
          else
            args = extract_args t
            result[scopes.join('.')] = args
          end
        end

        rec.call t, []

        result
      end

      def extract_args(translation)
        translation.to_s.scan(/(?<!%)%\{([^\}]+)\}/).flatten
      end

    end
  end
end
