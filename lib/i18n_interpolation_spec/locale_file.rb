require 'yaml'

module I18nInterpolationSpec
  class LocaleFile

    attr_accessor :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def content
      @content ||= File.read @filepath
    end

    def translations
      @translations ||= YAML.load(content).freeze
    end

    def locale
      @locale ||= translations.keys.first
    end

  end
end
