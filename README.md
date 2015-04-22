i18n_interpolation_spec
=======================

**i18n_interpolation_spec provides RSpec matchers for testing the completeness of interpolation arguments in locale files.**  
It's great to use with [tigrish/i18n-spec](https://github.com/tigrish/i18n-spec).


Installation
------------

Add the gem to your Gemfile.

```ruby
gem 'i18n_interpolation_spec', group: :test
```


Matchers
--------

```ruby
describe 'config/locales/fr.yml' do
  it { is_expected.to be_a_complete_interpolation_of 'config/locales/en.yml' }
end

describe 'config/locales/it.yml' do
  it { is_expected.to have_mutual_interpolation_of 'config/locales/en.yml' }
end

describe 'config/locales/es.yml' do
  it {
    is_expected.to be_a_complete_interpolation_of 'config/locales/en.yml',
      except: [
        'some.key.to.ignore',
        /^some\.patt[e3]rn\.to\.ignore/,
      ]
  }
end
```


License
-------

This project is copyright by [Creasty](http://creasty.com), released under the MIT license.  
See `LICENSE` file for details.
