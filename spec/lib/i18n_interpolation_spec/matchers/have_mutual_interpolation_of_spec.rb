require 'spec_helper'

describe 'have_mutual_interpolation_of' do

  describe 'spec/fixtures/complete.yml' do
    it { is_expected.to have_mutual_interpolation_of 'spec/fixtures/base.yml' }
  end

  describe 'spec/fixtures/incomplete.yml' do
    it { is_expected.to have_mutual_interpolation_of 'spec/fixtures/base.yml' }
  end

end
