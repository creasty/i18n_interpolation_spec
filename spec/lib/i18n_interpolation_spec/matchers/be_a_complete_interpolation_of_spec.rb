require 'spec_helper'

describe 'be_a_complete_interpolation_of' do

  describe 'spec/fixtures/complete.yml' do
    it { is_expected.to be_a_complete_interpolation_of 'spec/fixtures/base.yml' }
  end

  describe 'spec/fixtures/incomplete.yml' do
    it { is_expected.not_to be_a_complete_interpolation_of 'spec/fixtures/base.yml' }
  end

  context 'With exceptions' do

    describe 'spec/fixtures/incomplete.yml' do
      it do
        is_expected.to be_a_complete_interpolation_of 'spec/fixtures/base.yml',
          except: [
            'foo.text_1',
            'foo.text_2',
          ]
      end
    end

  end

end
