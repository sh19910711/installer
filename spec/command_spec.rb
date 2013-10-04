require 'spec_helper'

describe 'command' do
  it 'GNU m4' do
    ret = `$HOME/local/bin/m4 --version`
    ret.include?('m4 (GNU M4) 1.4.1').should == true
  end
  it 'GNU Make' do
    ret = `$HOME/local/bin/make --version`
    ret.include?('GNU Make 3.8').should == true
  end
  it 'git' do
    ret = `$HOME/local/bin/git --version`
    ret.should('git version 1.8.4').should == true
  end
end
