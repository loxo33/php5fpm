require 'spec_helper'
describe 'php5fpm' do

  context 'with defaults for all parameters' do
    it { should contain_class('php5fpm') }
  end
end
