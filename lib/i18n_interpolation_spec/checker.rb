module I18nInterpolationSpec
  module Checker
    class << self

      def check(t1, t2)
        a1, a2 = interpolations(t1), interpolations(t2)
        missing_keys = {}

        a1.each do |(scope, keys)|
          next unless a2.respond_to? :[]
          diff = keys - (a2[scope] || [])
          missing_keys[scope] = diff unless diff.empty?
        end

        missing_keys
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
            result[scopes.join('.')] = args unless args.empty?
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
