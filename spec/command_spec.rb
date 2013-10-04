require 'spec_helper'

describe 'command' do
  it 'GNU m4' do
    ret = `$HOME/local/bin/m4 --version`
    ret.include?('m4 (GNU M4) 1.4.1') == true
  end
  it 'GNU Make' do
    ret = `$HOME/local/bin/make --version`
    ret.include?('GNU Make 3.8') == true
  end
end
