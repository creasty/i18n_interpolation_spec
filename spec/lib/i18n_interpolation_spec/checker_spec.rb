require 'spec_helper'

describe I18nInterpolationSpec::Checker do

  describe '::extract_args' do

    it 'should extract interpolation args' do
      text = 'non_arg %{arg_1} {non_arg} %{arg_2}'
      args = %w[arg_1 arg_2]

      expect(I18nInterpolationSpec::Checker.extract_args(text)).to eq args
    end

    it 'should not extract args of interpolation-like syntax with escaped %' do
      text = '%{arg} %%{non_arg}'
      non_arg = 'non_arg'

      expect(I18nInterpolationSpec::Checker.extract_args(text)).not_to include non_arg
    end

  end

  describe '::interpolations' do

    it 'should return pairs of scope and interpolation args' do
      translations = {
        a: { aa: '%{a_aa_arg}', ab: '%{a_ab_arg}' },
        b: { ba: '%{b_ba_arg}' },
        c: [{ ca: '%{c_0_ca_arg}' }],
      }

      args = {
        'a.aa'   => %w[a_aa_arg],
        'a.ab'   => %w[a_ab_arg],
        'b.ba'   => %w[b_ba_arg],
        'c.0.ca' => %w[c_0_ca_arg],
      }

      expect(I18nInterpolationSpec::Checker.interpolations(translations)).to eq args
    end

  end

  describe '::check' do

    it 'should return an empty hash if interpolation args are fully contained in both arg lists' do
      t1 = {
        a: { aa: '%{a_aa_arg}', ab: '%{a_ab_arg}' },
        b: { ba: '%{b_ba_arg}' },
        c: [{ ca: '%{c_0_ca_arg}' }],
      }
      t2 = {
        a: { aa: '%{a_aa_arg}', ab: '%{a_ab_arg}' },
        b: { ba: '%{b_ba_arg}' },
        c: [{ ca: '%{c_0_ca_arg}' }],
      }

      expect(I18nInterpolationSpec::Checker.check(t1, t2)).to eq({})
    end

    it 'should return a hash of missing translations args if interpolation args are not fully contained in both arg lists' do
      t1 = {
        a: { aa: '%{a_aa_arg}', ab: '%{a_ab_arg}' },
        b: { ba: '%{b_ba_arg}' },
        c: [{ ca: '%{c_0_ca_arg}' }],
      }
      t2 = {
        a: { aa: '%{a_aa_arg}', ab: '%{a_ab_k3y}' },
        b: { ba: '' },
        c: [{ ca: '%{c_0_ca_arg}' }],
      }

      args = {
        'a.ab' => %w[a_ab_arg],
        'b.ba' => %w[b_ba_arg],
      }

      expect(I18nInterpolationSpec::Checker.check(t1, t2)).to eq args
    end

  end

end
