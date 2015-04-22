require 'spec_helper'

describe I18nInterpolationSpec::Checker do

  describe '::extract_args' do

    it 'should extract interpolation arguments' do
      text = 'non_arg %{arg_1} {non_arg} %{arg_2}'
      args = %w[arg_1 arg_2]

      expect(I18nInterpolationSpec::Checker.extract_args(text)).to eq args
    end

    it 'should not extract arguments of interpolation-like syntax with escaped %' do
      text = '%{arg} %%{non_arg}'
      non_arg = 'non_arg'

      expect(I18nInterpolationSpec::Checker.extract_args(text)).not_to include non_arg
    end

  end

  describe '::interpolations' do

    it 'should return pairs of scope and interpolation arguments' do
      translations = {
        a: { aa: '%{a_aa}', ab: '%{a_ab}' },
        b: { ba: '%{b_ba}' },
        c: [{ ca: '%{c_0_ca}' }],
      }

      args = {
        'a.aa'   => %w[a_aa],
        'a.ab'   => %w[a_ab],
        'b.ba'   => %w[b_ba],
        'c.0.ca' => %w[c_0_ca],
      }

      expect(I18nInterpolationSpec::Checker.interpolations(translations)).to eq args
    end

    it 'should include empty array for translations without interpolations' do
      translations = {
        a: { aa: '%{a_aa}' },
        b: { ba: 'no interpolations here' },
      }

      args = {
        'a.aa'   => %w[a_aa],
        'b.ba'   => %w[],
      }

      expect(I18nInterpolationSpec::Checker.interpolations(translations)).to eq args
    end

  end

  let(:t1) do
    {
      a: { aa: '%{a_aa}', ab: '%{a_ab}' },
      b: { ba: '%{b_ba}' },
      c: [{ ca: '%{c_0_ca}' }],
    }
  end

  let(:t2) do
    {
      a: { aa: '%{a_aa}', ab: '%{a_ab}' },
      b: { ba: '%{b_ba}' },
      c: [{ ca: '%{c_0_ca}' }],
    }
  end

  describe '::strict_check' do

    it 'should return an empty hash if interpolation arguments are fully contained in both arg lists' do
      expect(I18nInterpolationSpec::Checker.strict_check(t1, t2)).to eq({})
    end

    it 'should ignore translations that only exists in either hash' do
      t1[:d] = { only_1: '%{only_1}' }
      t2[:d] = { only_2: '%{only_2}' }

      expect(I18nInterpolationSpec::Checker.strict_check(t1, t2)).to eq({})
    end

    it 'should return a hash of missing translations arguments if interpolation arguments are not fully contained in both arg lists' do
      t1[:c][0][:ca] = ''
      t2[:a][:ab]    = '%{A_AB}'
      t2[:b][:ba]    = ''

      args = {
        'a.ab'   => %w[a_ab A_AB],
        'b.ba'   => %w[b_ba],
        "c.0.ca" => %w[c_0_ca],
      }

      expect(I18nInterpolationSpec::Checker.strict_check(t1, t2)).to eq args
    end

  end

  describe '::loose_check' do

    it 'should return an empty hash if interpolation arguments are fully contained in both arg lists' do
      expect(I18nInterpolationSpec::Checker.loose_check(t1, t2)).to eq({})
    end

    it 'should ignore translations that only exists in either hash' do
      t1[:d] = { only_1: '%{only_1}' }
      t2[:d] = { only_2: '%{only_2}' }

      expect(I18nInterpolationSpec::Checker.loose_check(t1, t2)).to eq({})
    end

    it 'should return a hash of missing translations arguments if interpolation arguments are not fully contained in both arg lists' do
      t1[:a][:aa]    = '%{a_aa} %{only}'
      t1[:c][0][:ca] = ''
      t2[:a][:ab]    = '%{A_AB}'
      t2[:b][:ba]    = '%{B_BA} %{only}'

      args = {
        'a.ab' => %w[a_ab A_AB],
        'b.ba' => %w[b_ba B_BA only],
      }

      expect(I18nInterpolationSpec::Checker.loose_check(t1, t2)).to eq args
    end

  end

end
