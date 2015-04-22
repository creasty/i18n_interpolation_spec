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

    def content_yaml
      @content_yaml ||= YAML.load(content).freeze
    end

    def locale
      @locale ||= content_yaml.keys.first
    end

    def translations
      content_yaml[locale]
    end

  end
end
