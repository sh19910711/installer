require 'spec_helper'

describe 'command' do
  it 'm4' do
    `$HOME/local/bin/m4 --version`.contain?('m4 (GNU M4) 1.4.1') == true
  end
end
