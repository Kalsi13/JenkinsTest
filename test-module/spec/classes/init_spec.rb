require 'spec_helper'
describe 'module' do

  context 'with defaults for all parameters' do
    it { should contain_class('module') }
  end
end
