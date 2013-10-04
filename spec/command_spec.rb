require 'spec_helper'

describe 'command' do
  it 'm4' do
    ret = `$HOME/local/bin/m4 --version`
    ret.include?('m4 (GNU M4) 1.4.1') == true
  end
end
