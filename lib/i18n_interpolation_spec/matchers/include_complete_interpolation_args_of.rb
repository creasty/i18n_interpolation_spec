RSpec::Matchers.define :include_complete_interpolation_args_of do |subject_filepath|

  match do |object_filepath|
    object_locale  = I18nInterpolationSpec::LocaleFile.new object_filepath
    subject_locale = I18nInterpolationSpec::LocaleFile.new subject_filepath

    t1, t2 = subject_locale.translations, object_locale.translations

    @missing_args = I18nInterpolationSpec::Checker.strict_check t1, t2
    @missing_args.empty?
  end

  failure_message do |filepath|
    listed = @missing_args.map do |(scope, args)|
      args = args.map { |arg| '%%{%s}' % arg }.join ', '
      "\n - %s should have %s" % [scope, args]
    end

    "expected #{filepath} to contain the following interpolation arguments:#{listed.join}"
  end

end
