require 'spec_helper'

describe 'include_complete_interpolation_args_of' do

  describe 'spec/fixtures/complete.yml' do
    it { is_expected.to include_complete_interpolation_args_of 'spec/fixtures/base.yml' }
  end

  describe 'spec/fixtures/incomplete.yml' do
    it { is_expected.not_to include_complete_interpolation_args_of 'spec/fixtures/base.yml' }
  end

end
