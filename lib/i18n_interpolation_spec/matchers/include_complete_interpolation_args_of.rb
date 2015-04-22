RSpec::Matchers.define :include_complete_interpolation_args_of do |subject_filepath|

  match do |object_filepath|
    object_locale  = I18nInterpolationSpec::LocaleFile.new object_filepath
    subject_locale = I18nInterpolationSpec::LocaleFile.new subject_filepath

    t1, t2 = subject_locale.translations, object_locale.translations

    @missing_args = I18nInterpolationSpec::Checker.check t1, t2
    @missing_args.empty?
  end

  failure_message do |filepath|
    listed = @missing_args
      .map { |(scope, keys)| "\n - %s should have %%{%s}" % [scope, keys.join(', ')] }

    "expected #{filepath} to contain the following interpolation arguments:#{listed.join}"
  end

end
