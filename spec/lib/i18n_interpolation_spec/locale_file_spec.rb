require 'spec_helper'

module LocaleFileHelper

  def locale_file_with_content(content)
    locale_file = I18nInterpolationSpec::LocaleFile.new 'test.yml'
    locale_file.stub(:content) { content }
    locale_file
  end

end


describe I18nInterpolationSpec::LocaleFile do
  include LocaleFileHelper

  describe '#content' do

    it 'should return the content of the file' do
      content = <<-YAML
        en:
          hello: world
      YAML

      locale_file = locale_file_with_content content

      expect(locale_file.content).to eq(content)
    end

  end

  describe '#content_yaml' do

    it 'should return a hash object of translations' do
      locale_file = locale_file_with_content <<-YAML
        en:
          hello: world
      YAML

      hash = {
        'en' => {
          'hello' => 'world'
        }
      }

      expect(locale_file.content_yaml).to eq(hash)
    end

  end

  describe '#locale' do

    it 'should return the locale code of the file' do
      locale_file = locale_file_with_content <<-YAML
        en:
          hello: world
      YAML

      expect(locale_file.locale).to eq('en')
    end

  end

  describe '#translations' do

    it 'should return a hash object of translations' do
      locale_file = locale_file_with_content <<-YAML
        en:
          hello: world
      YAML

      hash = {
        'hello' => 'world'
      }

      expect(locale_file.translations).to eq(hash)
    end

  end

end
