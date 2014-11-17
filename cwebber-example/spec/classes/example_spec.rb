require 'spec_helper'

describe "example" do

it do
  should contain_file('/foo').with({
    'ensure'  => 'present',
    'content' => %r{^bar}
  })
end
end
