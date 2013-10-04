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
    ret.include?('git version 1.8.4').should == true
  end
  it 'tar' do
    ret = `$HOME/local/bin/tar --version`
    ret.include?('tar (GNU tar) 1.26').should == true
  end
  it 'coreutils' do
    ret = `$HOME/local/bin/install --version`
    ret.include?('install (GNU coreutils) 8.21').should == true
  end
end
